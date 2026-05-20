import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/events.dart';
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
/// l'input touch/mouse e tastiera (tasti D, F, J, K).
class BeatForgeGame extends FlameGame
    with KeyboardEvents, TapCallbacks, DragCallbacks {
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

  // Traccia le coordinate iniziali e i tempi dei gesti di trascinamento (multi-touch)
  final Map<int, Offset> _dragStartPositions = {};
  final Map<int, int> _dragStartTimes = {};
  // Traccia se il drag di un pointer ha già triggerato un flick
  final Set<int> _dragFlicked = {};
  // Traccia la corsia dove è iniziato il drag per il rilascio hold
  final Map<int, int> _dragStartLanes = {};

  /// Registra la pressione di un tasto/tocco in una corsia
  void pressLane(int laneIndex) {
    if (laneIndex >= 0 && laneIndex < 4) {
      _lanes[laneIndex].triggerPress();
      controller.pressLane(laneIndex);
    }
  }

  /// Registra il rilascio di un tasto/tocco in una corsia
  void releaseLane(int laneIndex) {
    if (laneIndex >= 0 && laneIndex < 4) {
      controller.releaseLane(laneIndex);
    }
  }

  /// Calcola la corsia (0-3) a partire dalla coordinata X locale
  int? _getLaneFromX(double x) {
    if (size.x <= 0) return null;
    final int lane = (x / (size.x / 4)).floor();
    return lane.clamp(0, 3);
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    final lane = _getLaneFromX(event.localPosition.x);
    if (lane != null) {
      pressLane(lane);
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    final lane = _getLaneFromX(event.localPosition.x);
    if (lane != null) {
      releaseLane(lane);
    }
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    final lane = _getLaneFromX(event.localPosition.x);
    if (lane != null) {
      // Non chiamiamo pressLane subito: aspettiamo di capire se è un flick o un hold/tap.
      // La pressione verrà registrata solo se il drag non si risolve in un flick.
      _dragStartPositions[event.pointerId] = event.localPosition.toOffset();
      _dragStartTimes[event.pointerId] = DateTime.now().millisecondsSinceEpoch;
      _dragStartLanes[event.pointerId] = lane;
    }
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    // Se questo pointer ha già generato un flick, ignoriamo i successivi update
    if (_dragFlicked.contains(event.pointerId)) return;

    final startPos = _dragStartPositions[event.pointerId];
    final startTime = _dragStartTimes[event.pointerId];
    if (startPos != null && startTime != null) {
      final currentPos = event.localEndPosition.toOffset();
      final delta = currentPos - startPos;
      final dist = delta.distance;
      final elapsed = DateTime.now().millisecondsSinceEpoch - startTime;

      // Soglia più generosa: 20px di distanza in 400ms (era 30px / 250ms)
      if (dist > 20.0 && elapsed < 400) {
        final lane = _getLaneFromX(startPos.dx);
        if (lane != null) {
          // Determina la direzione del flick
          String direction = 'up';
          if (delta.dx.abs() > delta.dy.abs()) {
            direction = delta.dx > 0 ? 'right' : 'left';
          } else {
            direction = delta.dy > 0 ? 'down' : 'up';
          }

          controller.handleFlick(lane, direction);

          // Segnala che questo pointer ha già fliccato (non triggerare pressLane al rilascio)
          _dragFlicked.add(event.pointerId);
          _dragStartPositions.remove(event.pointerId);
          _dragStartTimes.remove(event.pointerId);
        }
      }
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    // Se il drag non ha triggerato un flick, lo trattiamo come tap/hold
    if (!_dragFlicked.contains(event.pointerId)) {
      final lane = _dragStartLanes[event.pointerId];
      if (lane != null) {
        // Registra press + release per catturare tap normali o hold brevi
        pressLane(lane);
        releaseLane(lane);
      }
    } else {
      // Era un flick: rilascia comunque la corsia per sicurezza
      final lane = _dragStartLanes[event.pointerId];
      if (lane != null) releaseLane(lane);
    }
    _dragStartPositions.remove(event.pointerId);
    _dragStartTimes.remove(event.pointerId);
    _dragStartLanes.remove(event.pointerId);
    _dragFlicked.remove(event.pointerId);
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    super.onDragCancel(event);
    if (!_dragFlicked.contains(event.pointerId)) {
      final lane = _dragStartLanes[event.pointerId];
      if (lane != null) releaseLane(lane);
    }
    _dragStartPositions.remove(event.pointerId);
    _dragStartTimes.remove(event.pointerId);
    _dragStartLanes.remove(event.pointerId);
    _dragFlicked.remove(event.pointerId);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Esegue il calcolo logico dei MISS nel controller ad ogni frame
    controller.updateGameplay();

    // Gestione dello spawn dinamico basato sul tempo audio
    if (controller.status == GameplayStatus.playing) {
      final int songTimeMs = controller.currentSongTimeMs;
      final double preSpawnWindow = controller.difficultyProfile.approachTimeMs
          .toDouble();

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
    int? laneIndex;
    if (event.logicalKey == LogicalKeyboardKey.keyD) laneIndex = 0;
    if (event.logicalKey == LogicalKeyboardKey.keyF) laneIndex = 1;
    if (event.logicalKey == LogicalKeyboardKey.keyJ) laneIndex = 2;
    if (event.logicalKey == LogicalKeyboardKey.keyK) laneIndex = 3;

    if (laneIndex != null) {
      if (event is KeyDownEvent) {
        pressLane(laneIndex);
        return KeyEventResult.handled;
      } else if (event is KeyUpEvent) {
        releaseLane(laneIndex);
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }
}
