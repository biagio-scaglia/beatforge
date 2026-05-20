import 'package:flutter/material.dart';
import '../../../../shared/theme/app_assets.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/theme/app_tokens.dart';
import '../../../../shared/widgets/beatforge_loader.dart';
import '../../../../shared/widgets/glow_text.dart';

/// Schermata di splash iniziale animata.
///
/// Mostra il logo BeatForge neon pulsante e un caricamento a barre stilizzato,
/// dopodiché procede all'avvio effettivo dell'applicazione tramite la callback [onFinish].
class SplashScreen extends StatefulWidget {
  /// Callback invocata al termine dell'animazione e del caricamento iniziale
  final VoidCallback onFinish;

  const SplashScreen({super.key, required this.onFinish});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _fadeController.forward();
    _startTransitionTimer();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _startTransitionTimer() async {
    // Breve ritardo per dare il tempo di mostrare il brand
    await Future.delayed(const Duration(milliseconds: 1600));
    if (!mounted) return;
    widget.onFinish();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo grafico dell'applicazione
              Image.asset(
                AppAssets.logo,
                width: 100,
                height: 100,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: AppTokens.spacingLg),
              // Logo con stile Orbitron e bagliore neon cyan
              const GlowText(
                'BEATFORGE',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Orbitron',
                  letterSpacing: 8.0,
                  color: AppTheme.primaryCyan,
                ),
                glowColor: AppTheme.primaryCyan,
              ),
              const SizedBox(height: AppTokens.spacingSm),
              Text(
                'FUTURISTIC RHYTHM STUDIO',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4.0,
                  color: AppTheme.secondaryMagenta.withValues(alpha: 0.8),
                  fontFamily: 'Orbitron',
                ),
              ),
              const SizedBox(height: 60),
              // Loader neon personalizzato
              const BeatForgeLoader(height: 32, width: 50, barWidth: 3),
            ],
          ),
        ),
      ),
    );
  }
}
