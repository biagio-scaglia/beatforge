import 'package:flutter/material.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/widgets/glow_text.dart';
import '../../../shared/widgets/neon_card.dart';

/// La schermata principale (Home) di BeatForge.
///
/// Presenta il titolo con effetto neon e le opzioni principali organizzate
/// in una griglia responsive che si adatta orizzontalmente o verticalmente
/// in base allo spazio disponibile.
class HomeScreen extends StatelessWidget {
  /// Callback attivata quando l'utente sceglie di aprire la libreria musicale.
  final VoidCallback onNavigateToLibrary;

  const HomeScreen({super.key, required this.onNavigateToLibrary});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 900),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              GlowText(
                'BEATFORGE',
                glowColor: AppTheme.primaryCyan,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppTheme.primaryCyan,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4.0,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Crea e gioca mappe rhythm in locale',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textSecondary,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 48),

              // Layout adattivo per le card principali di interazione
              LayoutBuilder(
                builder: (context, constraints) {
                  final bool isWide = constraints.maxWidth > 550;

                  final List<Widget> cardList = [
                    Expanded(
                      flex: isWide ? 1 : 0,
                      child: NeonCard(
                        glowColor: AppTheme.primaryCyan,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppTheme.surfaceElevated,
                              content: Text(
                                'Gameplay non ancora implementato in questo step.',
                                style: TextStyle(
                                  color: AppTheme.primaryCyan,
                                  fontFamily: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.fontFamily,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryCyan.withOpacity(0.08),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                color: AppTheme.primaryCyan,
                                size: 48,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'AVVIA SESSIONE',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(color: AppTheme.primaryCyan),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Inizia a suonare o modifica i tuoi beatmap preferiti',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                    if (!isWide) const SizedBox(height: 20),
                    if (isWide) const SizedBox(width: 24),
                    Expanded(
                      flex: isWide ? 1 : 0,
                      child: NeonCard(
                        glowColor: AppTheme.secondaryMagenta,
                        onTap: onNavigateToLibrary,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppTheme.secondaryMagenta.withOpacity(
                                  0.08,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.library_music_rounded,
                                color: AppTheme.secondaryMagenta,
                                size: 48,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'APRI LIBRERIA',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(color: AppTheme.secondaryMagenta),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Esplora le tracce audio importate e le tue creazioni',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                  ];

                  // IntrinsicHeight è necessario in modalità orizzontale (isWide) per costringere
                  // le schede ad assumere la stessa altezza naturale calcolata dal contenuto più grande.
                  return isWide
                      ? IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: cardList,
                          ),
                        )
                      : Column(
                          children: cardList.map((w) {
                            if (w is Expanded) return w.child;
                            return w;
                          }).toList(),
                        );
                },
              ),

              const SizedBox(height: 40),

              // Scheda informativa che indica che l'applicazione è in esecuzione in locale offline
              NeonCard(
                glowColor: AppTheme.tertiaryYellow,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 16.0,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.cloud_off_rounded,
                      color: AppTheme.tertiaryYellow,
                      size: 24,
                    ),
                    const SizedBox(width: 16),
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
                            'Nessun server esterno. I dati e i punteggi salvati rimarranno al sicuro sul tuo dispositivo.',
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
            ],
          ),
        ),
      ),
    );
  }
}
