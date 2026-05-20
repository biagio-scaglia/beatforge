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
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: AppTokens.spacingXl),

        // Colonna Destra: Mascotte in posa musicale a figura libera affiancata alla dashboard
        Expanded(
          flex: 5,
          child: Center(
            child: SizedBox(
              width: 420,
              height: 320,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: const [
                  // Dashboard di mockup
                  Positioned(left: 20, top: 40, child: _CyberDashboardMockup()),

                  // Mascotte a figura intera che fluttua ed interagisce a lato
                  Positioned(
                    right: 0,
                    bottom: -10,
                    child: BeatChanHeroComposition(
                      size: 230,
                      pose: BeatChanPose.fullBody,
                      isFloating: true,
                    ),
                  ),
                ],
              ),
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

        // Pannello informativo compatto con mascotte in posa busto/musica affiancata
        Container(
          padding: const EdgeInsets.all(AppTokens.spacingMd),
          decoration: BoxDecoration(
            color: AppTheme.surfaceElevated.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.borderSubtle),
          ),
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rhythm Game Studio',
                      style: TextStyle(
                        color: AppTheme.primaryCyan,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Orbitron',
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Gestisci le tue tracce in totale privacy ed edita beatmap personalizzate.',
                      style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppTokens.spacingMd),
              const BeatChanHeroComposition(
                size: 100,
                pose: BeatChanPose.music,
                isFloating: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTokens.spacingLg),

        // Bottoni CTA
        SizedBox(
          width: double.infinity,
          child: NeonButton(
            text: 'Apri Libreria',
            icon: Icons.library_music_rounded,
            glowColor: AppTheme.primaryCyan,
            onTap: onNavigateToLibrary,
          ),
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
}

/// Mockup grafico di una dashboard di editing musicale per accompagnare visivamente la mascotte.
class _CyberDashboardMockup extends StatelessWidget {
  const _CyberDashboardMockup();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 200,
      padding: const EdgeInsets.all(AppTokens.spacingMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceElevated.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.primaryCyan.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryCyan.withValues(alpha: 0.1),
            blurRadius: 16,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Barre di intestazione in stile finestra OS
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const Spacer(),
              const Text(
                'BEATMAP_EDITOR_v1.0',
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 7,
                  fontFamily: 'Orbitron',
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.spacingMd),

          // Traccia in esecuzione fittizia
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppTheme.background.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.borderSubtle),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.music_note,
                  color: AppTheme.primaryCyan,
                  size: 14,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Cybernetic Dreams.mp3',
                        style: TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'BPM: 140 • Notes: 248',
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 7,
                          fontFamily: 'Orbitron',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTokens.spacingSm),

          // Barre equalizzatore statiche ma estetiche
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildWaveBar(18, AppTheme.primaryCyan),
              _buildWaveBar(35, AppTheme.primaryCyan),
              _buildWaveBar(55, AppTheme.secondaryMagenta),
              _buildWaveBar(40, AppTheme.primaryCyan),
              _buildWaveBar(20, AppTheme.secondaryMagenta),
              _buildWaveBar(45, AppTheme.primaryCyan),
              _buildWaveBar(10, AppTheme.primaryCyan),
            ],
          ),
          const Spacer(),

          // Finta barra temporale
          Row(
            children: const [
              Text(
                '01:14',
                style: TextStyle(color: AppTheme.textSecondary, fontSize: 7),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.0),
                  child: LinearProgressIndicator(
                    value: 0.45,
                    backgroundColor: AppTheme.borderSubtle,
                    color: AppTheme.primaryCyan,
                    minHeight: 2,
                  ),
                ),
              ),
              Text(
                '02:40',
                style: TextStyle(color: AppTheme.textSecondary, fontSize: 7),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWaveBar(double height, Color color) {
    return Container(
      width: 3,
      height: height / 2,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(1.5),
      ),
    );
  }
}
