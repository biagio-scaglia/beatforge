import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../models/gameplay_state.dart';
import 'beatforge_game.dart';

/// Componente grafico Flame base per rappresentare una nota nel gameplay.
/// Utilizza una factory per istanziare la corretta sottoclasse a seconda del tipo di nota.
abstract class NoteComponent extends PositionComponent
    with HasGameReference<BeatForgeGame> {
  final NoteRuntimeModel noteModel;

  // Costanti visive
  static const double noteRadius = 24.0;

  // Stadi dell'animazione post-giudizio
  bool _isExploding = false;
  bool _isFadingOutMiss = false;
  double _animationTimer = 0.0;
  static const double explosionDuration = 0.15; // secondi
  static const double missDuration = 0.20; // secondi

  late Paint ringPaint;
  late Paint glowPaint;
  late Paint centerPaint;

  // Timer per l'animazione di spawn scale-in (i primi 150ms di vita)
  double _spawnTimer = 0.0;
  static const double _spawnDuration = 0.15; // secondi

  // Timer accumulato per il pulse della hold note (evita allocazione DateTime ogni frame)
  double _holdPulseTimer = 0.0;

  NoteComponent._internal({required this.noteModel});

  factory NoteComponent({required NoteRuntimeModel noteModel}) {
    if (noteModel.type == 'hold') {
      return HoldNoteComponent(noteModel: noteModel);
    } else if (noteModel.type == 'flick') {
      return FlickNoteComponent(noteModel: noteModel);
    } else {
      return TapNoteComponent(noteModel: noteModel);
    }
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Inizializza i pennelli per lo stile Neon Cyberpunk (Cyan/Magenta)
    final bool isEvenLane = noteModel.lane % 2 == 0;
    final Color primaryColor = isEvenLane
        ? const Color(0xFF00F2FE) // Cyan neon
        : const Color(0xFFFF007F); // Magenta neon

    ringPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    glowPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    centerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Dimensione del componente per centrare il rendering
    size = Vector2(noteRadius * 2, noteRadius * 2);
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Avanza il timer di spawn per l'animazione scale-in
    if (_spawnTimer < _spawnDuration) {
      _spawnTimer += dt;
    }

    // Avanza il timer del pulse hold (usato da HoldNoteComponent)
    _holdPulseTimer += dt;

    // Gestione dell'animazione di hit (esplosione)
    if (_isExploding) {
      _animationTimer += dt;
      if (_animationTimer >= explosionDuration) {
        removeFromParent();
      }
      return;
    }

    // Gestione dell'animazione di miss
    if (_isFadingOutMiss) {
      _animationTimer += dt;
      if (_animationTimer >= missDuration) {
        removeFromParent();
      }
      return;
    }

    // Rileva se il controller ha contrassegnato la nota come colpita o persa
    if (noteModel.isHit) {
      _isExploding = true;
      _animationTimer = 0.0;
      return;
    }

    if (noteModel.isMissed) {
      _isFadingOutMiss = true;
      _animationTimer = 0.0;
      return;
    }

    updatePosition();
  }

  /// Aggiorna la posizione della nota sul Canvas.
  /// Sovrascritto da HoldNoteComponent per logiche particolari.
  void updatePosition() {
    final controller = game.controller;
    if (controller.status == GameplayStatus.playing) {
      final int songTimeMs = controller.currentSongTimeMs;

      final double spawnY = 60.0;
      final double targetY = game.size.y - 120.0;

      final double timeDiff = noteModel.timeMs.toDouble() - songTimeMs;
      final double approachTime = controller.difficultyProfile.approachTimeMs
          .toDouble();
      final double ratio = (timeDiff / approachTime).clamp(-0.2, 1.0);

      // Y scende da spawnY (quando ratio = 1) a targetY (quando ratio = 0)
      final double calculatedY = targetY - (ratio * (targetY - spawnY));

      // Calcola X in base alla corsia
      final double laneWidth = game.size.x / 4;
      final double calculatedX = (noteModel.lane + 0.5) * laneWidth;

      position = Vector2(calculatedX, calculatedY);
    }
  }

  @override
  void render(Canvas canvas) {
    final double center = size.x / 2;

    if (_isExploding) {
      final double progress = (_animationTimer / explosionDuration).clamp(
        0.0,
        1.0,
      );
      final double scale = 1.0 + (progress * 0.8);
      final double alpha = 1.0 - progress;

      final Paint explosionPaint = Paint()
        ..color = ringPaint.color.withValues(alpha: alpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0 * (1.0 - progress);

      final Paint fillPaint = Paint()
        ..color = Colors.white.withValues(alpha: alpha * 0.6)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(center, center),
        noteRadius * scale,
        explosionPaint,
      );
      canvas.drawCircle(
        Offset(center, center),
        noteRadius * 0.6 * scale,
        fillPaint,
      );
      return;
    }

    if (_isFadingOutMiss) {
      final double progress = (_animationTimer / missDuration).clamp(0.0, 1.0);
      final double alpha = 1.0 - progress;

      final Paint fadePaint = Paint()
        ..color = const Color(0xFFEF4444).withValues(alpha: alpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      canvas.drawCircle(Offset(center, center), noteRadius, fadePaint);
      return;
    }

    // Disegno nota standard con scale-in all'inizio della vita
    final double spawnScale = (_spawnTimer / _spawnDuration).clamp(0.0, 1.0);
    canvas.save();
    canvas.translate(center, center);
    canvas.scale(spawnScale);
    canvas.translate(-center, -center);
    canvas.drawCircle(Offset(center, center), noteRadius + 4, glowPaint);
    canvas.drawCircle(Offset(center, center), noteRadius, ringPaint);
    canvas.drawCircle(Offset(center, center), noteRadius * 0.4, centerPaint);

    final Paint innerRing = Paint()
      ..color = Colors.black.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(Offset(center, center), noteRadius * 0.6, innerRing);
    canvas.restore();
  }
}

/// Nota di tipo standard: singola pressione rapida (Tap).
class TapNoteComponent extends NoteComponent {
  TapNoteComponent({required super.noteModel}) : super._internal();
}

/// Nota di tipo Flick: richiede uno swipe rapido in una direzione specifica.
class FlickNoteComponent extends NoteComponent {
  FlickNoteComponent({required super.noteModel}) : super._internal();

  @override
  void render(Canvas canvas) {
    // Disegna la forma di base della nota
    super.render(canvas);

    if (_isExploding || _isFadingOutMiss) return;

    final double center = size.x / 2;
    final String dir = (noteModel.direction ?? 'up').toLowerCase();

    canvas.save();
    canvas.translate(center, center);

    // Ruota la tela a seconda della direzione indicata
    if (dir == 'right') {
      canvas.rotate(90 * 3.14159265 / 180);
    } else if (dir == 'down') {
      canvas.rotate(180 * 3.14159265 / 180);
    } else if (dir == 'left') {
      canvas.rotate(-90 * 3.14159265 / 180);
    }

    // Definisce il tracciato della freccia rivolta verso l'alto (up)
    final Path arrowPath = Path();
    arrowPath.moveTo(0, -14);
    arrowPath.lineTo(-10, -2);
    arrowPath.lineTo(-4, -2);
    arrowPath.lineTo(-4, 10);
    arrowPath.lineTo(4, 10);
    arrowPath.lineTo(4, -2);
    arrowPath.lineTo(10, -2);
    arrowPath.close();

    final Paint arrowPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Paint arrowGlow = Paint()
      ..color = ringPaint.color.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawPath(arrowPath, arrowPaint);
    canvas.drawPath(arrowPath, arrowGlow);
    canvas.restore();
  }
}

/// Nota di tipo Hold: richiede una pressione prolungata per tutta la sua durata.
class HoldNoteComponent extends NoteComponent {
  double tailY = 0.0;
  double headY = 0.0;

  HoldNoteComponent({required super.noteModel}) : super._internal();

  @override
  void updatePosition() {
    final controller = game.controller;
    if (controller.status == GameplayStatus.playing) {
      final int songTimeMs = controller.currentSongTimeMs;

      final double spawnY = 60.0;
      final double targetY = game.size.y - 120.0;
      final double approachTime = controller.difficultyProfile.approachTimeMs
          .toDouble();

      // Calcola Head Y (se la hold è già iniziata, la testa si blocca sulla Judgment Line)
      if (noteModel.holdStarted && !noteModel.holdCompleted) {
        headY = targetY;
      } else {
        final double headDiff = noteModel.timeMs.toDouble() - songTimeMs;
        final double headRatio = (headDiff / approachTime).clamp(-0.2, 1.0);
        headY = targetY - (headRatio * (targetY - spawnY));
      }

      // Calcola Tail Y
      final double tailTime = (noteModel.timeMs + (noteModel.durationMs ?? 0))
          .toDouble();
      final double tailDiff = tailTime - songTimeMs;
      final double tailRatio = (tailDiff / approachTime).clamp(-0.2, 1.0);
      tailY = targetY - (tailRatio * (targetY - spawnY));

      final double laneWidth = game.size.x / 4;
      final double calculatedX = (noteModel.lane + 0.5) * laneWidth;

      position = Vector2(calculatedX, headY);
    }
  }

  @override
  void render(Canvas canvas) {
    final double center = size.x / 2;

    if (_isExploding) {
      // Disegna l'animazione di esplosione sulla testa
      super.render(canvas);
      return;
    }

    if (_isFadingOutMiss) {
      // Disegna l'animazione di miss sulla testa
      super.render(canvas);
      return;
    }

    // Calcola la posizione Y della coda (tail) locale alla testa
    final double tailLocalY = tailY - headY;

    // 1. Disegna la striscia/capsula neon che unisce testa e coda
    final double bodyWidth = NoteComponent.noteRadius * 1.2;
    final Paint bodyPaint = Paint()
      ..color = ringPaint.color.withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;

    final Paint bodyBorder = Paint()
      ..color = ringPaint.color.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final RRect sustainCapsule = RRect.fromRectAndRadius(
      Rect.fromLTRB(
        center - bodyWidth / 2,
        tailLocalY,
        center + bodyWidth / 2,
        center,
      ),
      const Radius.circular(NoteComponent.noteRadius * 0.6),
    );

    canvas.drawRRect(sustainCapsule, bodyPaint);
    canvas.drawRRect(sustainCapsule, bodyBorder);

    // Linea centrale brillante
    final Paint corePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawLine(
      Offset(center, tailLocalY),
      Offset(center, center),
      corePaint,
    );

    // 2. Disegna l'anello finale della coda (Tail)
    final Paint tailPaint = Paint()
      ..color = ringPaint.color.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawCircle(
      Offset(center, tailLocalY),
      NoteComponent.noteRadius * 0.7,
      tailPaint,
    );

    // 3. Disegna la testa standard (Head)
    super.render(canvas);

    // 4. Glow animato pulsante se la hold è tenuta attiva
    // Usa _holdPulseTimer accumulato tramite dt (no DateTime.now() ogni frame)
    if (noteModel.holdStarted &&
        !noteModel.holdCompleted &&
        !noteModel.isMissed) {
      final double pulse =
          1.0 + 0.15 * (((_holdPulseTimer * 1000) % 500) / 500);
      final Paint activeGlow = Paint()
        ..color = ringPaint.color.withValues(alpha: 0.4)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);
      canvas.drawCircle(
        Offset(center, center),
        NoteComponent.noteRadius * 1.5 * pulse,
        activeGlow,
      );
    }
  }
}
