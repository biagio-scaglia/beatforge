import 'package:shared_preferences/shared_preferences.dart';

/// Repository per la persistenza locale delle impostazioni usando SharedPreferences.
class SettingsRepository {
  final SharedPreferences _prefs;

  SettingsRepository(this._prefs);

  static const _keyLatency = 'settings_latency';
  static const _keyGlow = 'settings_glow';
  static const _keyMusicVol = 'settings_music_vol';
  static const _keySfxVol = 'settings_sfx_vol';
  static const _keyDifficulty = 'settings_difficulty';
  static const _keySort = 'settings_library_sort';

  /// Latenza audio (offset) in millisecondi. Default: 0
  int getLatencyOffset() => _prefs.getInt(_keyLatency) ?? 0;
  Future<bool> setLatencyOffset(int value) => _prefs.setInt(_keyLatency, value);

  /// Abilitazione effetti glow neon. Default: true
  bool getGlowEffects() => _prefs.getBool(_keyGlow) ?? true;
  Future<bool> setGlowEffects(bool value) => _prefs.setBool(_keyGlow, value);

  /// Volume della musica (0.0 - 1.0). Default: 1.0
  double getMusicVolume() => _prefs.getDouble(_keyMusicVol) ?? 1.0;
  Future<bool> setMusicVolume(double value) =>
      _prefs.setDouble(_keyMusicVol, value);

  /// Volume degli effetti sonori (0.0 - 1.0). Default: 1.0
  double getSfxVolume() => _prefs.getDouble(_keySfxVol) ?? 1.0;
  Future<bool> setSfxVolume(double value) =>
      _prefs.setDouble(_keySfxVol, value);

  /// Difficoltà predefinita ("Easy", "Normal", "Hard", "Expert"). Default: "Normal"
  String getDefaultDifficulty() => _prefs.getString(_keyDifficulty) ?? 'Normal';
  Future<bool> setDefaultDifficulty(String value) =>
      _prefs.setString(_keyDifficulty, value);

  /// Criterio di ordinamento libreria predefinito. Default: "Title"
  String getLibrarySort() => _prefs.getString(_keySort) ?? 'Title';
  Future<bool> setLibrarySort(String value) =>
      _prefs.setString(_keySort, value);
}
