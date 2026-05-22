import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

/// Sistema di effetti particellari neon per il gameplay di BeatForge.
///
/// Espone factory statiche per creare burst di scintille in stile cyberpunk
/// che vengono aggiunti direttamente all'albero dei componenti Flame.
/// Ogni effetto è autogestito: si aggiunge, esegue l'animazione e poi si rimuove.

/// Crea e restituisce un [ParticleSystemComponent] con scintille neon
/// per il feedback di una nota colpita (tap/flick).
///
/// [position] — posizione nel canvas Flame dove spawnare l'effetto
/// [color] — colore neon delle particelle (cyan per corsia pari, magenta per dispari)
ParticleSystemComponent createHitParticles({
  required Vector2 position,
  required Color color,
}) {
  final rng = Random();

  // Genera 10 scintille radiali che si espandono verso l'esterno
  final particles = List<Particle>.generate(10, (_) {
    // Angolo casuale per ogni scintilla
    final angle = rng.nextDouble() * 2 * pi;
    // Velocità casuale tra 60 e 150 px/s
    final speed = 60.0 + rng.nextDouble() * 90.0;

    final dx = cos(angle) * speed;
    final dy = sin(angle) * speed;

    return AcceleratedParticle(
      // Leggera gravità verso il basso per naturalezza
      acceleration: Vector2(0, 40),
      speed: Vector2(dx, dy),
      child: FadeOutParticle(
        lifespan: 0.35 + rng.nextDouble() * 0.15,
        child: ScaledParticle(
          scale: 0.4 + rng.nextDouble() * 0.6,
          child: CircleParticle(radius: 3.0, paint: Paint()..color = color),
        ),
      ),
    );
  });

  return ParticleSystemComponent(
    position: position,
    particle: ComposedParticle(children: particles),
  );
}

/// Crea un burst più intenso per il giudizio PERFECT.
/// Genera più particelle, di dimensioni maggiori e con un alone bianco centrale.
///
/// [position] — posizione nel canvas Flame dove spawnare l'effetto
/// [color] — colore neon principale (es. cyan o magenta)
ParticleSystemComponent createPerfectBurstParticles({
  required Vector2 position,
  required Color color,
}) {
  final rng = Random();

  // 16 scintille per un burst più vistoso
  final sparks = List<Particle>.generate(16, (i) {
    // Distribuzione angolare uniforme + piccola variazione casuale
    final angle = (i / 16) * 2 * pi + (rng.nextDouble() - 0.5) * 0.4;
    final speed = 80.0 + rng.nextDouble() * 100.0;

    final dx = cos(angle) * speed;
    final dy = sin(angle) * speed;

    return AcceleratedParticle(
      acceleration: Vector2(0, 50),
      speed: Vector2(dx, dy),
      child: FadeOutParticle(
        lifespan: 0.4 + rng.nextDouble() * 0.2,
        child: ScaledParticle(
          scale: 0.5 + rng.nextDouble() * 0.8,
          child: CircleParticle(radius: 4.0, paint: Paint()..color = color),
        ),
      ),
    );
  });

  // Anello di luce centrale che si espande e svanisce (ring burst)
  final ringBurst = List<Particle>.generate(8, (i) {
    final angle = (i / 8) * 2 * pi;
    const speed = 40.0;
    final dx = cos(angle) * speed;
    final dy = sin(angle) * speed;

    return AcceleratedParticle(
      acceleration: Vector2.zero(),
      speed: Vector2(dx, dy),
      child: FadeOutParticle(
        lifespan: 0.25,
        child: ScaledParticle(
          scale: 1.5,
          child: CircleParticle(
            radius: 2.5,
            paint: Paint()..color = Colors.white,
          ),
        ),
      ),
    );
  });

  return ParticleSystemComponent(
    position: position,
    particle: ComposedParticle(children: [...sparks, ...ringBurst]),
  );
}

class FadeOutParticle extends Particle {
  final Particle child;

  FadeOutParticle({
    required this.child,
    super.lifespan,
  });

  @override
  void setLifespan(double lifespan) {
    super.setLifespan(lifespan);
    child.setLifespan(lifespan);
  }

  @override
  void render(Canvas canvas) {
    final opacity = (1.0 - progress).clamp(0.0, 1.0);
    canvas.saveLayer(null, Paint()..color = Colors.white.withValues(alpha: opacity));
    child.render(canvas);
    canvas.restore();
  }

  @override
  void update(double dt) {
    super.update(dt);
    child.update(dt);
  }
}
