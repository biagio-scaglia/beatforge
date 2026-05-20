import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../navigation/presentation/app_shell.dart';
import '../../onboarding/presentation/onboarding_screen.dart';
import 'splash_screen.dart';

/// Stati di avvio dell'applicazione.
enum AppStartupState {
  /// Stato iniziale dello splash screen
  splash,

  /// Stato di onboarding (solo primo avvio)
  onboarding,

  /// Navigazione principale dell'applicazione caricata
  mainShell,
}

/// Involucro che orchestra le fasi di avvio dell'app: Splash -> Onboarding -> App Shell.
class AppStartupWrapper extends StatefulWidget {
  const AppStartupWrapper({super.key});

  @override
  State<AppStartupWrapper> createState() => _AppStartupWrapperState();
}

class _AppStartupWrapperState extends State<AppStartupWrapper> {
  AppStartupState _startupState = AppStartupState.splash;

  @override
  Widget build(BuildContext context) {
    switch (_startupState) {
      case AppStartupState.splash:
        return SplashScreen(onFinish: _checkOnboardingStatus);
      case AppStartupState.onboarding:
        return OnboardingScreen(
          onFinish: () {
            setState(() {
              _startupState = AppStartupState.mainShell;
            });
          },
        );
      case AppStartupState.mainShell:
        return const AppShell();
    }
  }

  Future<void> _checkOnboardingStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final bool completed = prefs.getBool('onboarding_completed') ?? false;

      if (!mounted) return;
      setState(() {
        _startupState = completed
            ? AppStartupState.mainShell
            : AppStartupState.onboarding;
      });
    } catch (_) {
      // In caso di errore nel caricamento preferenze, procedi in sicurezza alla shell principale
      if (!mounted) return;
      setState(() {
        _startupState = AppStartupState.mainShell;
      });
    }
  }
}
