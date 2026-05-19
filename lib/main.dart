import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/navigation/presentation/app_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BeatForgeApp());
}

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
