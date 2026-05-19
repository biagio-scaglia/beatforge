import 'package:flutter/material.dart';
import 'data/local/database/app_database.dart';
import 'data/repositories/audio_repository.dart';
import 'features/navigation/presentation/app_shell.dart';
import 'shared/theme/app_theme.dart';

void main() {
  // Garantisce che il binding del framework sia inizializzato correttamente
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();
  final repository = AudioRepository(database);

  runApp(
    AudioRepositoryProvider(
      repository: repository,
      child: const BeatForgeApp(),
    ),
  );
}

/// Punto di ingresso principale (root) dell'applicazione BeatForge.
///
/// Inizializza l'applicazione configurando il titolo globale, disattivando il
/// banner di debug e impostando il tema personalizzato scuro neon prima di
/// caricare lo scheletro dell'interfaccia ([AppShell]).
class BeatForgeApp extends StatelessWidget {
  const BeatForgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeatForge',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const AppShell(),
    );
  }
}
