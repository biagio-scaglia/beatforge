import 'package:flutter/material.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/theme/app_tokens.dart';
import '../../../shared/widgets/glow_text.dart';
import '../../../shared/widgets/neon_card.dart';
import '../../../shared/widgets/neon_button.dart';
import '../../../shared/widgets/beatchan_artwork.dart';
import '../../../shared/widgets/beatchan_hero_composition.dart';

/// La schermata principale (Home) di BeatForge.
///
/// Presenta la hero section responsive con la mascotte ufficiale dell'app,
/// Beat-chan, integrando informazioni ed i collegamenti rapidi principali.
class HomeScreen extends StatelessWidget {
  /// Callback attivata quando l'utente sceglie di aprire la libreria musicale.
  final VoidCallback onNavigateToLibrary;

  const HomeScreen({super.key, required this.onNavigateToLibrary});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTokens.spacingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppTokens.spacingMd),

              // Hero Section responsive
              LayoutBuilder(
                builder: (context, constraints) {
                  final bool isWide = constraints.maxWidth >= 720;

                  if (isWide) {
                    return _buildDesktopHero(context);
                  } else {
                    return _buildMobileHero(context);
                  }
                },
              ),

              const SizedBox(height: AppTokens.spacingXl),

              // Scheda informativa che indica che l'applicazione è in esecuzione in locale offline
              NeonCard(
                glowColor: AppTheme.tertiaryYellow,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTokens.spacingLg,
                  vertical: AppTokens.spacingMd,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.cloud_off_rounded,
                      color: AppTheme.tertiaryYellow,
                      size: 24,
                    ),
                    const SizedBox(width: AppTokens.spacingMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MODALITÀ LOCALE ATTIVA',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.tertiaryYellow,
                                  fontSize: 13,
                                  letterSpacing: 0.5,
                                ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Nessun server esterno. I dati, le beatmap ed i punteggi salvati rimarranno al sicuro sul tuo dispositivo.',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTokens.spacingMd),
            ],
          ),
        ),
      ),
    );
  }

  /// Layout della Hero Section per schermi grandi (desktop/tablet)
  Widget _buildDesktopHero(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Colonna Sinistra: Testi e Pulsanti CTA
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBadge(context),
              const SizedBox(height: AppTokens.spacingMd),
              GlowText(
                'BEATFORGE',
                glowColor: AppTheme.primaryCyan,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: AppTheme.primaryCyan,
                  fontWeight: FontWeight.bold,
                  fontSize: 48,
                  letterSpacing: 4.0,
                ),
              ),
              const SizedBox(height: AppTokens.spacingSm),
              Text(
                'Crea e gioca mappe rhythm in locale',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.textPrimary,
                  fontSize: 20,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: AppTokens.spacingMd),
              Text(
                'Gestisci la tua collezione musicale in totale privacy ed edita beatmap personalizzate con precisione millesimale su una timeline orizzontale reattiva.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: AppTokens.spacingXl),
              Row(
                children: [
                  NeonButton(
                    text: 'Apri Libreria',
                    icon: Icons.library_music_rounded,
                    glowColor: AppTheme.primaryCyan,
                    onTap: onNavigateToLibrary,
                  ),
                  const SizedBox(width: AppTokens.spacingMd),
                  NeonButton(
                    text: 'Avvia Sessione',
                    icon: Icons.play_arrow_rounded,
                    glowColor: AppTheme.secondaryMagenta,
                    isSecondary: true,
                    onTap: () => _showNotImplementedSnackBar(context),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: AppTokens.spacingXl),

        // Colonna Destra: Mascotte in posa musicale a figura libera
        const Expanded(
          flex: 4,
          child: Center(
            child: BeatChanHeroComposition(
              size: 320,
              pose: BeatChanPose.fullBody,
              isFloating: true,
            ),
          ),
        ),
      ],
    );
  }

  /// Layout della Hero Section per schermi compatti (mobile)
  Widget _buildMobileHero(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Mascotte centrale in scala ridotta per preservare lo spazio
        const BeatChanHeroComposition(
          size: 200,
          pose: BeatChanPose.fullBody,
          isFloating: true,
        ),
        const SizedBox(height: AppTokens.spacingLg),

        _buildBadge(context),
        const SizedBox(height: AppTokens.spacingSm),
        GlowText(
          'BEATFORGE',
          glowColor: AppTheme.primaryCyan,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: AppTheme.primaryCyan,
            fontWeight: FontWeight.bold,
            letterSpacing: 3.0,
          ),
        ),
        const SizedBox(height: AppTokens.spacingXs),
        Text(
          'Crea e gioca mappe rhythm in locale',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppTheme.textPrimary,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: AppTokens.spacingMd),
        Text(
          'Gestisci la tua collezione musicale in locale ed edita beatmap personalizzate con precisione millesimale.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
            fontSize: 13,
            height: 1.5,
          ),
        ),
        const SizedBox(height: AppTokens.spacingLg),
        Wrap(
          spacing: AppTokens.spacingMd,
          runSpacing: AppTokens.spacingSm,
          alignment: WrapAlignment.center,
          children: [
            NeonButton(
              text: 'Apri Libreria',
              icon: Icons.library_music_rounded,
              glowColor: AppTheme.primaryCyan,
              onTap: onNavigateToLibrary,
            ),
            NeonButton(
              text: 'Avvia Sessione',
              icon: Icons.play_arrow_rounded,
              glowColor: AppTheme.secondaryMagenta,
              isSecondary: true,
              onTap: () => _showNotImplementedSnackBar(context),
            ),
          ],
        ),
      ],
    );
  }

  /// Badge stilizzato in stile cyberpunk/arcade
  Widget _buildBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.secondaryMagenta.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppTokens.radiusSm),
        border: Border.all(
          color: AppTheme.secondaryMagenta.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: const Text(
        'PROTOTIPO LOCALE-FIRST',
        style: TextStyle(
          color: AppTheme.secondaryMagenta,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
          fontFamily: 'Orbitron',
        ),
      ),
    );
  }

  void _showNotImplementedSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.surfaceElevated,
        content: Text(
          'Gameplay non ancora implementato in questo step.',
          style: TextStyle(
            color: AppTheme.primaryCyan,
            fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
          ),
        ),
      ),
    );
  }
}
