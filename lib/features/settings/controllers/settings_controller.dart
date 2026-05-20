import 'package:flutter/foundation.dart';
import '../../../data/repositories/settings_repository.dart';

/// Controller per gestire lo stato delle impostazioni dell'app e la persistenza.
class SettingsController extends ChangeNotifier {
  final SettingsRepository _repository;

  int _latencyOffset;
  bool _glowEffects;
  double _musicVolume;
  double _sfxVolume;
  String _defaultDifficulty;
  String _librarySort;

  SettingsController(this._repository)
    : _latencyOffset = _repository.getLatencyOffset(),
      _glowEffects = _repository.getGlowEffects(),
      _musicVolume = _repository.getMusicVolume(),
      _sfxVolume = _repository.getSfxVolume(),
      _defaultDifficulty = _repository.getDefaultDifficulty(),
      _librarySort = _repository.getLibrarySort();

  // Getter
  int get latencyOffset => _latencyOffset;
  bool get glowEffects => _glowEffects;
  double get musicVolume => _musicVolume;
  double get sfxVolume => _sfxVolume;
  String get defaultDifficulty => _defaultDifficulty;
  String get librarySort => _librarySort;

  // Setter
  Future<void> setLatencyOffset(int value) async {
    if (_latencyOffset == value) return;
    _latencyOffset = value;
    await _repository.setLatencyOffset(value);
    notifyListeners();
  }

  Future<void> setGlowEffects(bool value) async {
    if (_glowEffects == value) return;
    _glowEffects = value;
    await _repository.setGlowEffects(value);
    notifyListeners();
  }

  Future<void> setMusicVolume(double value) async {
    if (_musicVolume == value) return;
    _musicVolume = value;
    await _repository.setMusicVolume(value);
    notifyListeners();
  }

  Future<void> setSfxVolume(double value) async {
    if (_sfxVolume == value) return;
    _sfxVolume = value;
    await _repository.setSfxVolume(value);
    notifyListeners();
  }

  Future<void> setDefaultDifficulty(String value) async {
    if (_defaultDifficulty == value) return;
    _defaultDifficulty = value;
    await _repository.setDefaultDifficulty(value);
    notifyListeners();
  }

  Future<void> setLibrarySort(String value) async {
    if (_librarySort == value) return;
    _librarySort = value;
    await _repository.setLibrarySort(value);
    notifyListeners();
  }
}
