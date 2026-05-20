import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../controllers/gameplay_controller.dart';
import '../models/gameplay_state.dart';
import 'lane_component.dart';
import 'note_component.dart';

/// Il motore grafico Flame per BeatForge.
///
/// Disegna l'area di gioco principale, gestisce il posizionamento delle corsie,
/// esegue il game loop e spawn delle note al millisecondo corretto, e intercetta
/// l'input da tastiera (tasti D, F, J, K) per il test su Desktop e Web.
class BeatForgeGame extends FlameGame with KeyboardEvents {
  final GameplayController controller;

  final List<LaneComponent> _lanes = [];
  int _nextNoteSpawnIndex = 0;

  BeatForgeGame({required this.controller});

  @override
  Color backgroundColor() => Colors.transparent; // Lo sfondo scuro viene gestito da Flutter

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Genera le 4 corsie verticali
    for (int i = 0; i < 4; i++) {
      final lane = LaneComponent(laneIndex: i);
      _lanes.add(lane);
      add(lane);
    }

    resetSpawner();
  }

  /// Resetta l'indice di spawn per il riavvio del brano.
  void resetSpawner() {
    _nextNoteSpawnIndex = 0;
    // Rimuove eventuali NoteComponent residue
    children.whereType<NoteComponent>().forEach(
      (note) => note.removeFromParent(),
    );
  }

  /// Registra la pressione di un tasto in una corsia
  void pressLane(int laneIndex) {
    if (laneIndex >= 0 && laneIndex < 4) {
      _lanes[laneIndex].triggerPress();
      controller.handleInput(laneIndex);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Esegue il calcolo logico dei MISS nel controller ad ogni frame
    controller.updateGameplay();

    // Gestione dello spawn dinamico basato sul tempo audio
    if (controller.status == GameplayStatus.playing) {
      final int songTimeMs = controller.currentSongTimeMs;
      const double preSpawnWindow = NoteComponent.preSpawnWindow;

      // Spawna le note la cui finestra visiva è iniziata
      while (_nextNoteSpawnIndex < controller.notes.length) {
        final note = controller.notes[_nextNoteSpawnIndex];

        if (songTimeMs >= note.timeMs - preSpawnWindow) {
          add(NoteComponent(noteModel: note));
          _nextNoteSpawnIndex++;
        } else {
          break; // Le note sono ordinate, quindi ci fermiamo alla prima non idonea
        }
      }
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Disegna la Judgment Line (linea di giudizio) orizzontale neon cyberpunk
    final double targetY = size.y - 120.0;

    // Glow della Judgment Line
    final Paint lineGlowPaint = Paint()
      ..color = const Color(0x7F00F2FE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawLine(Offset(0, targetY), Offset(size.x, targetY), lineGlowPaint);

    // Linea Judgment solida cyan
    final Paint linePaint = Paint()
      ..color = const Color(0xFF00F2FE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawLine(Offset(0, targetY), Offset(size.x, targetY), linePaint);
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    // Intercetta la sola pressione iniziale del tasto per evitare lo spam ripetuto da hold
    if (event is KeyDownEvent) {
      int? laneIndex;
      if (event.logicalKey == LogicalKeyboardKey.keyD) laneIndex = 0;
      if (event.logicalKey == LogicalKeyboardKey.keyF) laneIndex = 1;
      if (event.logicalKey == LogicalKeyboardKey.keyJ) laneIndex = 2;
      if (event.logicalKey == LogicalKeyboardKey.keyK) laneIndex = 3;

      if (laneIndex != null) {
        pressLane(laneIndex);
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }
}
