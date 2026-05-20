import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'beatforge_game.dart';

/// Componente grafico Flame per rappresentare una corsia (lane) di gioco.
///
/// Disegna le linee di confine laterali ed un effetto di "pressione" lampeggiante
/// con sfumatura neon quando l'utente tapperà o userà la tastiera per colpire le note.
class LaneComponent extends PositionComponent
    with HasGameReference<BeatForgeGame> {
  final int laneIndex;

  // Stato animazione pressione
  bool _isPressed = false;
  double _flashTimer = 0.0;
  static const double flashDuration = 0.15; // secondi

  late Paint _borderPaint;
  late Paint _activeFlashPaint;
  late Paint _laneBgPaint;

  LaneComponent({required this.laneIndex});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Dimensione e posizione agganciata a quella dello schermo di gioco
    // Si estende per tutta l'altezza dello schermo, larghezza pari a 1/4 del totale
    final double laneWidth = game.size.x / 4;
    size = Vector2(laneWidth, game.size.y);
    position = Vector2(laneIndex * laneWidth, 0);

    // Stili grafici
    _borderPaint = Paint()
      ..color =
          const Color(0xFF1E294B) // Blu scuro cyberpunk
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    _laneBgPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    // Sfumatura neon per l'effetto pressione
    final Color neonColor = laneIndex % 2 == 0
        ? const Color(0xFF00F2FE) // Cyan neon
        : const Color(0xFFFF007F); // Magenta neon

    _activeFlashPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          neonColor.withValues(alpha: 0.35),
          neonColor.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, game.size.y - 300, laneWidth, 300));
  }

  /// Triggera l'effetto visivo di flash sulla corsia.
  void triggerPress() {
    _isPressed = true;
    _flashTimer = 0.0;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Aggiorna la larghezza e altezza in caso di resize dello schermo
    final double laneWidth = game.size.x / 4;
    size = Vector2(laneWidth, game.size.y);
    position = Vector2(laneIndex * laneWidth, 0);

    final bool isCurrentlyPressed = game.controller.isLanePressed(laneIndex);
    if (isCurrentlyPressed) {
      _isPressed = true;
      _flashTimer = 0.0;
    } else {
      if (_isPressed) {
        _flashTimer += dt;
        if (_flashTimer >= flashDuration) {
          _isPressed = false;
        }
      }
    }
  }

  @override
  void render(Canvas canvas) {
    // Sfondo corsia
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), _laneBgPaint);

    // Bordo destro (per dividere le corsie)
    if (laneIndex < 3) {
      canvas.drawLine(Offset(size.x, 0), Offset(size.x, size.y), _borderPaint);
    }

    // Effetto flash pressione tasto
    if (_isPressed) {
      final double progress = (_flashTimer / flashDuration).clamp(0.0, 1.0);
      final double opacity = 1.0 - progress;

      // Disegna un fascio di luce sfumato dal basso (judgment line) verso l'alto
      final Paint flashPaint = Paint()
        ..shader = _activeFlashPaint.shader
        ..colorFilter = ColorFilter.mode(
          Colors.white.withValues(alpha: opacity),
          BlendMode.modulate,
        );

      canvas.drawRect(Rect.fromLTWH(0, size.y - 350, size.x, 350), flashPaint);
    }
  }
}
