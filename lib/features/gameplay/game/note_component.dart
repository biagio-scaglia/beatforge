import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../models/gameplay_state.dart';
import 'beatforge_game.dart';

/// Componente grafico Flame per rappresentare una singola nota nel gameplay.
///
/// La posizione della nota è interamente calcolata in base alla differenza di tempo tra il
/// tempo di hit pianificato (`noteModel.timeMs`) e il tempo audio corrente del controller.
class NoteComponent extends PositionComponent
    with HasGameReference<BeatForgeGame> {
  final NoteRuntimeModel noteModel;

  // Costanti visive
  static const double preSpawnWindow = 1200.0; // Finestra di scorrimento in ms
  static const double noteRadius = 24.0;

  // Stadi dell'animazione post-giudizio
  bool _isExploding = false;
  bool _isFadingOutMiss = false;
  double _animationTimer = 0.0;
  static const double explosionDuration = 0.15; // secondi
  static const double missDuration = 0.20; // secondi

  late Paint _ringPaint;
  late Paint _glowPaint;
  late Paint _centerPaint;

  NoteComponent({required this.noteModel});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Inizializza i pennelli per lo stile Neon Cyberpunk (Cyan/Magenta)
    final bool isEvenLane = noteModel.lane % 2 == 0;
    final Color primaryColor = isEvenLane
        ? const Color(0xFF00F2FE) // Cyan neon
        : const Color(0xFFFF007F); // Magenta neon

    _ringPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    _glowPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    _centerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Dimensione del componente per centrare il rendering
    size = Vector2(noteRadius * 2, noteRadius * 2);
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);

    final controller = game.controller;

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

    // Calcolo della posizione Y basata rigorosamente sul tempo audio estrapolato
    if (controller.status == GameplayStatus.playing) {
      final int songTimeMs = controller.currentSongTimeMs;

      final double spawnY = 60.0;
      final double targetY = game.size.y - 120.0;

      final double timeDiff = noteModel.timeMs.toDouble() - songTimeMs;
      final double ratio = (timeDiff / preSpawnWindow).clamp(-0.2, 1.0);

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
      // Effetto esplosione: cerchio che si espande e svanisce
      final double progress = (_animationTimer / explosionDuration).clamp(
        0.0,
        1.0,
      );
      final double scale = 1.0 + (progress * 0.8);
      final double alpha = 1.0 - progress;

      final Paint explosionPaint = Paint()
        ..color = _ringPaint.color.withValues(alpha: alpha)
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
      // Effetto miss: la nota svanisce scendendo leggermente
      final double progress = (_animationTimer / missDuration).clamp(0.0, 1.0);
      final double alpha = 1.0 - progress;

      final Paint fadePaint = Paint()
        ..color = const Color(0xFFEF4444).withValues(alpha: alpha)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      canvas.drawCircle(Offset(center, center), noteRadius, fadePaint);
      return;
    }

    // Disegno nota standard
    // 1. Glow di sfondo
    canvas.drawCircle(Offset(center, center), noteRadius + 4, _glowPaint);

    // 2. Anello esterno neon
    canvas.drawCircle(Offset(center, center), noteRadius, _ringPaint);

    // 3. Nucleo bianco brillante
    canvas.drawCircle(Offset(center, center), noteRadius * 0.4, _centerPaint);

    // Decorazione interna (anello aggiuntivo molto sottile)
    final Paint innerRing = Paint()
      ..color = Colors.black.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(Offset(center, center), noteRadius * 0.6, innerRing);
  }
}
