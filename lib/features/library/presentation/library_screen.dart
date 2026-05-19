import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glow_text.dart';
import '../../../core/widgets/neon_card.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlowText(
                'LIBRERIA',
                glowColor: AppTheme.primaryCyan,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppTheme.primaryCyan,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Gestisci ed esporta le tue mappe beat musicali',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              NeonCard(
                glowColor: AppTheme.primaryCyan,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.queue_music_rounded,
                          color: AppTheme.primaryCyan,
                          size: 32,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Mappe Beat Locali',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Qui troverai l\'elenco di tutte le canzoni e le configurazioni di note create o importate nel tuo database locale SQLite.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Nessuna mappa presente. Inizia creando una nuova sessione o importando una traccia.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: AppTheme.textSecondary,
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
