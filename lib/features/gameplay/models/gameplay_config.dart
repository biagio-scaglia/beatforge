/// Rappresenta il profilo di difficoltà di una beatmap con i suoi parametri di gameplay.
/// Definisce Approach Rate (AR), finestre di precisione (timing windows) e bilanciamento della salute.
class DifficultyProfile {
  /// Nome leggibile del profilo
  final String name;

  /// Tempo in millisecondi in cui la nota resta visibile a schermo prima di raggiungere la judgment line
  final int approachTimeMs;

  /// Finestra di errore massima (ms) per registrare un giudizio PERFECT
  final int timingWindowPerfectMs;

  /// Finestra di errore massima (ms) per registrare un giudizio GREAT
  final int timingWindowGreatMs;

  /// Finestra di errore massima (ms) per registrare un giudizio GOOD
  final int timingWindowGoodMs;

  /// Penalità applicata alla barra della vita in caso di nota mancata (MISS)
  final double healthMissPenalty;

  /// Ricompensa applicata alla barra della vita per un giudizio PERFECT
  final double healthPerfectReward;

  /// Ricompensa applicata alla barra della vita per un giudizio GREAT
  final double healthGreatReward;

  /// Ricompensa applicata alla barra della vita per un giudizio GOOD
  final double healthGoodReward;

  const DifficultyProfile({
    required this.name,
    required this.approachTimeMs,
    required this.timingWindowPerfectMs,
    required this.timingWindowGreatMs,
    required this.timingWindowGoodMs,
    required this.healthMissPenalty,
    required this.healthPerfectReward,
    required this.healthGreatReward,
    required this.healthGoodReward,
  });

  /// Profilo di difficoltà Easy (facile): note visibili per molto tempo, finestre ampie e penalità ridotta.
  static const DifficultyProfile easy = DifficultyProfile(
    name: 'Easy',
    approachTimeMs: 1500,
    timingWindowPerfectMs: 50,
    timingWindowGreatMs: 100,
    timingWindowGoodMs: 150,
    healthMissPenalty: 8.0,
    healthPerfectReward: 3.0,
    healthGreatReward: 1.5,
    healthGoodReward: 0.5,
  );

  /// Profilo di difficoltà Normal (normale): bilanciamento standard di gioco.
  static const DifficultyProfile normal = DifficultyProfile(
    name: 'Normal',
    approachTimeMs: 1200,
    timingWindowPerfectMs: 40,
    timingWindowGreatMs: 80,
    timingWindowGoodMs: 120,
    healthMissPenalty: 12.0,
    healthPerfectReward: 2.0,
    healthGreatReward: 1.0,
    healthGoodReward: 0.2,
  );

  /// Profilo di difficoltà Hard (difficile): scorrimento più veloce, finestre strette, penalità elevata.
  static const DifficultyProfile hard = DifficultyProfile(
    name: 'Hard',
    approachTimeMs: 900,
    timingWindowPerfectMs: 30,
    timingWindowGreatMs: 60,
    timingWindowGoodMs: 90,
    healthMissPenalty: 16.0,
    healthPerfectReward: 1.5,
    healthGreatReward: 0.75,
    healthGoodReward: 0.1,
  );

  /// Profilo di difficoltà Expert (esperto): lettura rapida, precisione millimetrica e alta penalità.
  static const DifficultyProfile expert = DifficultyProfile(
    name: 'Expert',
    approachTimeMs: 600,
    timingWindowPerfectMs: 20,
    timingWindowGreatMs: 40,
    timingWindowGoodMs: 60,
    healthMissPenalty: 22.0,
    healthPerfectReward: 1.0,
    healthGreatReward: 0.5,
    healthGoodReward: 0.0,
  );

  /// Restituisce il profilo di difficoltà associato a partire dal nome della beatmap (case-insensitive).
  factory DifficultyProfile.fromDifficultyName(String name) {
    final normalized = name.toLowerCase();
    if (normalized.contains('easy')) return easy;
    if (normalized.contains('expert')) return expert;
    if (normalized.contains('hard')) return hard;
    return normal;
  }
}
