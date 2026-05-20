import 'package:flutter/material.dart';

/// Giudizi di precisione per il tempismo dei tap.
enum Judgment {
  perfect(1000, 'PERFECT', Color(0xFF00F2FE)), // Cyan neon
  great(600, 'GREAT', Color(0xFFFF007F)), // Magenta neon
  good(300, 'GOOD', Color(0xFFFFF200)), // Yellow neon
  miss(0, 'MISS', Color(0xFFEF4444)); // Red neon

  final int score;
  final String label;
  final Color color;

  const Judgment(this.score, this.label, this.color);
}

/// Stati di avanzamento della partita.
enum GameplayStatus { ready, countdown, playing, paused, completed }

/// Modello a runtime per tenere traccia dello stato di una nota durante il gameplay.
class NoteRuntimeModel {
  final int id;
  final int timeMs;
  final int lane;
  final String type; // 'tap', 'hold', 'flick'
  final int? durationMs;
  final String? direction;

  /// Flag per indicare se la nota è stata colpita
  bool isHit = false;

  /// Flag per indicare se la nota è stata mancata
  bool isMissed = false;

  NoteRuntimeModel({
    required this.id,
    required this.timeMs,
    required this.lane,
    required this.type,
    this.durationMs,
    this.direction,
  });
}

/// Stato corrente del punteggio e dei giudizi della sessione.
class ScoringState {
  int score = 0;
  int combo = 0;
  int maxCombo = 0;

  int perfectCount = 0;
  int greatCount = 0;
  int goodCount = 0;
  int missCount = 0;

  void addJudgment(Judgment judgment) {
    if (judgment == Judgment.miss) {
      combo = 0;
      missCount++;
    } else {
      score += judgment.score;
      combo++;
      if (combo > maxCombo) {
        maxCombo = combo;
      }
      if (judgment == Judgment.perfect) perfectCount++;
      if (judgment == Judgment.great) greatCount++;
      if (judgment == Judgment.good) goodCount++;
    }
  }

  double get accuracy {
    final totalHits = perfectCount + greatCount + goodCount + missCount;
    if (totalHits == 0) return 100.0;

    // Calcolo percentuale accuratezza standard
    // Perfect = 100%, Great = 60%, Good = 30%, Miss = 0%
    final weightedPoints =
        (perfectCount * 1.0) + (greatCount * 0.6) + (goodCount * 0.3);
    return (weightedPoints / totalHits) * 100.0;
  }
}
