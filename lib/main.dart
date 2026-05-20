import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/local/database/app_database.dart';
import 'data/repositories/audio_repository.dart';
import 'data/repositories/beatmap_repository.dart';
import 'data/repositories/settings_repository.dart';
import 'features/settings/controllers/settings_controller.dart';
import 'features/settings/controllers/settings_provider.dart';
import 'features/splash/presentation/app_startup_wrapper.dart';
import 'shared/services/audio_player_service.dart';
import 'shared/services/audio_player_service_provider.dart';
import 'shared/theme/app_theme.dart';

Future<void> main() async {
  // Garantisce che il binding del framework sia inizializzato correttamente
  WidgetsFlutterBinding.ensureInitialized();

  // Inizializza SharedPreferences e SettingsController
  final prefs = await SharedPreferences.getInstance();
  final settingsRepository = SettingsRepository(prefs);
  final settingsController = SettingsController(settingsRepository);

  final database = AppDatabase();
  final repository = AudioRepository(database);
  final beatmapRepository = BeatmapRepository(database);
  final playerService = AudioPlayerService();

  runApp(
    SettingsProvider(
      controller: settingsController,
      child: AudioRepositoryProvider(
        repository: repository,
        child: BeatmapRepositoryProvider(
          repository: beatmapRepository,
          child: AudioPlayerServiceProvider(
            service: playerService,
            child: const BeatForgeApp(),
          ),
        ),
      ),
    ),
  );
}

/// Punto di ingresso principale (root) dell'applicazione BeatForge.
///
/// Inizializza l'applicazione configurando il titolo globale, disattivando il
/// banner di debug e impostando il tema personalizzato scuro neon prima di
/// caricare lo scheletro dell'interfaccia ([AppStartupWrapper]).
class BeatForgeApp extends StatelessWidget {
  const BeatForgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeatForge',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const AppStartupWrapper(),
    );
  }
}
