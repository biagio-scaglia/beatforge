import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/theme/app_tokens.dart';
import '../../../../shared/widgets/beatchan_hero_composition.dart';
import '../../../../shared/widgets/glow_text.dart';
import '../../../../shared/widgets/neon_button.dart';
import '../../../../shared/widgets/beatchan_artwork.dart';

/// Schermata di onboarding minimale e cyberpunk.
///
/// Spiega all'utente i concetti cardine di BeatForge (locale-first, importazione MP3, Beat-chan)
/// in 3 slide scorribili. Permette di saltare in qualunque momento e persiste il completamento.
class OnboardingScreen extends StatefulWidget {
  /// Callback invocata alla conclusione dell'onboarding
  final VoidCallback onFinish;

  const OnboardingScreen({super.key, required this.onFinish});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    widget.onFinish();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // Area intestazione / Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTokens.spacingLg,
                  vertical: AppTokens.spacingMd,
                ),
                child: _currentPage < 2
                    ? TextButton(
                        onPressed: _completeOnboarding,
                        child: Text(
                          'SALTA',
                          style: TextStyle(
                            color: AppTheme.secondaryMagenta.withValues(
                              alpha: 0.8,
                            ),
                            fontFamily: 'Orbitron',
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      )
                    : const SizedBox(height: 36), // Preserva l'altezza
              ),
            ),

            // Slider delle schede
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  _OnboardingPage(
                    title: 'LOCALE-FIRST',
                    description:
                        'Nessun database remoto, nessuna connessione obbligatoria. I tuoi dati e le tue beatmap musicali rimangono memorizzati in locale al sicuro.',
                    accentColor: AppTheme.primaryCyan,
                    illustration: _buildNeonIcon(
                      Icons.shield_outlined,
                      AppTheme.primaryCyan,
                    ),
                  ),
                  _OnboardingPage(
                    title: 'CARICA I TUOI MP3',
                    description:
                        'Importa i file audio direttamente dalla memoria del tuo dispositivo per iniziare a mappare o a suonare istantaneamente.',
                    accentColor: AppTheme.secondaryMagenta,
                    illustration: _buildNeonIcon(
                      Icons.library_music_outlined,
                      AppTheme.secondaryMagenta,
                    ),
                  ),
                  _OnboardingPage(
                    title: 'TI PRESENTO BEAT-CHAN',
                    description:
                        'La mascotte ufficiale di BeatForge ti terrà compagnia ed interagirà con te nell\'editor e nel gameplay.',
                    accentColor: AppTheme.primaryCyan,
                    illustration: const BeatChanHeroComposition(
                      size: 160,
                      pose: BeatChanPose.music,
                      isFloating: true,
                    ),
                  ),
                ],
              ),
            ),

            // Controlli inferiori (indicatori + bottone di avanzamento)
            Padding(
              padding: const EdgeInsets.all(AppTokens.spacingXl),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Indicatori a barre neon
                  Row(
                    children: List.generate(3, (index) {
                      final bool isSelected = _currentPage == index;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(right: 8),
                        width: isSelected ? 24 : 8,
                        height: 6,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? (index == 1
                                    ? AppTheme.secondaryMagenta
                                    : AppTheme.primaryCyan)
                              : AppTheme.borderSubtle,
                          borderRadius: BorderRadius.circular(3),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color:
                                        (index == 1
                                                ? AppTheme.secondaryMagenta
                                                : AppTheme.primaryCyan)
                                            .withValues(alpha: 0.6),
                                    blurRadius: 4,
                                  ),
                                ]
                              : [],
                        ),
                      );
                    }),
                  ),

                  // Bottone Avanti / Inizia
                  NeonButton(
                    text: _currentPage == 2 ? 'INIZIA' : 'AVANTI',
                    glowColor: _currentPage == 1
                        ? AppTheme.secondaryMagenta
                        : AppTheme.primaryCyan,
                    onTap: () {
                      if (_currentPage < 2) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _completeOnboarding();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNeonIcon(IconData icon, Color color) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
      ),
      child: Center(
        child: Icon(
          icon,
          size: 64,
          color: color,
          shadows: [
            Shadow(color: color.withValues(alpha: 0.6), blurRadius: 12),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final Color accentColor;
  final Widget illustration;

  const _OnboardingPage({
    required this.title,
    required this.description,
    required this.accentColor,
    required this.illustration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTokens.spacingXl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          illustration,
          const SizedBox(height: 50),
          GlowText(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'Orbitron',
              letterSpacing: 2.0,
              color: accentColor,
            ),
            glowColor: accentColor,
          ),
          const SizedBox(height: AppTokens.spacingMd),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
