import 'gameplay_state.dart';
import '../controllers/gameplay_controller.dart';

/// Interfaccia base per definire il comportamento specifico a runtime di ciascun tipo di nota.
abstract class NoteRuntimeBehavior {
  final NoteRuntimeModel model;

  NoteRuntimeBehavior(this.model);

  /// Invocato ad ogni frame del game loop per aggiornare lo stato interno.
  /// Ritorna true se lo stato visivo della nota è cambiato e occorre notificare la UI.
  bool update(int songTimeMs, GameplayController controller);

  /// Invocato quando l'utente effettua una pressione iniziale (tap down) sulla corsia.
  /// Ritorna il giudizio se la nota viene colpita, altrimenti null.
  Judgment? handleTapDown(int songTimeMs, GameplayController controller);

  /// Invocato quando l'utente rilascia (tap up) la pressione sulla corsia.
  /// Ritorna il giudizio (es. completamento o rilascio anticipato), altrimenti null.
  Judgment? handleTapUp(int songTimeMs, GameplayController controller);

  /// Invocato quando l'utente effettua uno swipe (flick) sulla corsia.
  /// Ritorna il giudizio se la nota viene colpita, altrimenti null.
  Judgment? handleFlick(
    int songTimeMs,
    String direction,
    GameplayController controller,
  );
}

/// Comportamento a runtime di una nota di tipo standard ("tap").
class TapNoteBehavior extends NoteRuntimeBehavior {
  TapNoteBehavior(super.model);

  @override
  bool update(int songTimeMs, GameplayController controller) {
    // Se la nota è passata oltre la tolleranza massima (Good Window) ed è attiva, è un MISS
    if (!model.isHit &&
        !model.isMissed &&
        songTimeMs >
            model.timeMs + controller.difficultyProfile.timingWindowGoodMs) {
      model.isMissed = true;
      return true;
    }
    return false;
  }

  @override
  Judgment? handleTapDown(int songTimeMs, GameplayController controller) {
    if (model.isHit || model.isMissed) return null;

    final diff = songTimeMs - model.timeMs;
    // Se il colpo è all'interno della finestra di tolleranza Good
    if (diff.abs() <= controller.difficultyProfile.timingWindowGoodMs) {
      model.isHit = true;
      return controller.evaluateTap(diff);
    }
    return null;
  }

  @override
  Judgment? handleTapUp(int songTimeMs, GameplayController controller) => null;

  @override
  Judgment? handleFlick(
    int songTimeMs,
    String direction,
    GameplayController controller,
  ) => null;
}

/// Comportamento a runtime di una nota di tipo strisciamento ("flick").
class FlickNoteBehavior extends NoteRuntimeBehavior {
  FlickNoteBehavior(super.model);

  @override
  bool update(int songTimeMs, GameplayController controller) {
    if (!model.isHit &&
        !model.isMissed &&
        songTimeMs >
            model.timeMs + controller.difficultyProfile.timingWindowGoodMs) {
      model.isMissed = true;
      return true;
    }
    return false;
  }

  @override
  Judgment? handleTapDown(int songTimeMs, GameplayController controller) {
    // I tap normali non attivano la flick note!
    return null;
  }

  @override
  Judgment? handleTapUp(int songTimeMs, GameplayController controller) => null;

  @override
  Judgment? handleFlick(
    int songTimeMs,
    String direction,
    GameplayController controller,
  ) {
    if (model.isHit || model.isMissed) return null;

    final diff = songTimeMs - model.timeMs;
    if (diff.abs() <= controller.difficultyProfile.timingWindowGoodMs) {
      // Accetta il flick se:
      // 1. La nota non ha una direzione specifica (qualunque swipe va bene)
      // 2. La direzione corrisponde esattamente
      final noteDir = model.direction?.toLowerCase();
      if (noteDir == null ||
          noteDir.isEmpty ||
          noteDir == direction.toLowerCase()) {
        model.isHit = true;
        return controller.evaluateTap(diff);
      }
      // Direzione sbagliata ma within window: registriamo lo stesso (leniency)
      // così l'utente non si ritrova nota impossibile da colpire
      model.isHit = true;
      return Judgment.good;
    }
    return null;
  }
}

/// Comportamento a runtime di una nota di tipo tenuta ("hold").
class HoldNoteBehavior extends NoteRuntimeBehavior {
  HoldNoteBehavior(super.model);

  @override
  bool update(int songTimeMs, GameplayController controller) {
    final profile = controller.difficultyProfile;

    // 1. La nota non è ancora iniziata e il tempo massimo d'inizio è scaduto
    if (!model.holdStarted &&
        !model.isMissed &&
        songTimeMs > model.timeMs + profile.timingWindowGoodMs) {
      model.isMissed = true;
      return true;
    }

    // 2. La nota è stata avviata ed è ancora in esecuzione
    if (model.holdStarted && !model.holdCompleted && !model.isMissed) {
      final endTime = model.timeMs + (model.durationMs ?? 0);

      // Se abbiamo superato la fine del brano/della nota con successo
      if (songTimeMs >= endTime) {
        model.holdCompleted = true;
        model.isHit = true;
        return true;
      }

      // Se la corsia non è più premuta, verifichiamo se l'utente ha rilasciato troppo presto
      if (!controller.isLanePressed(model.lane)) {
        final lastActive = model.holdLastActiveTimeMs ?? model.timeMs;
        // Tolleranza di 150ms prima di rompere definitivamente la hold
        if (songTimeMs - lastActive > 150) {
          model.isMissed = true;
          return true;
        }
      } else {
        // Aggiorna l'ultimo millisecondo attivo registrato
        model.holdLastActiveTimeMs = songTimeMs;
      }
    }
    return false;
  }

  @override
  Judgment? handleTapDown(int songTimeMs, GameplayController controller) {
    if (model.holdStarted || model.isMissed) return null;

    final diff = songTimeMs - model.timeMs;
    if (diff.abs() <= controller.difficultyProfile.timingWindowGoodMs) {
      model.holdStarted = true;
      model.holdLastActiveTimeMs = songTimeMs;
      // Forniamo subito un giudizio iniziale per dare feedback
      return controller.evaluateTap(diff);
    }
    return null;
  }

  @override
  Judgment? handleTapUp(int songTimeMs, GameplayController controller) {
    // Se rilasciamo la hold durante il sustain
    if (model.holdStarted && !model.holdCompleted && !model.isMissed) {
      final endTime = model.timeMs + (model.durationMs ?? 0);
      final diff = songTimeMs - endTime;

      // Se rilasciamo entro la finestra di tolleranza di fine hold, è completata!
      if (diff.abs() <= controller.difficultyProfile.timingWindowGoodMs) {
        model.holdCompleted = true;
        model.isHit = true;
        return controller.evaluateTap(diff);
      } else {
        // Rilascio troppo anticipato (al di fuori della tolleranza)
        model.isMissed = true;
        return Judgment.miss;
      }
    }
    return null;
  }

  @override
  Judgment? handleFlick(
    int songTimeMs,
    String direction,
    GameplayController controller,
  ) => null;
}
