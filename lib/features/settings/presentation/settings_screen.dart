import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glow_text.dart';
import '../../../core/widgets/neon_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                'OPZIONI',
                glowColor: AppTheme.secondaryMagenta,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppTheme.secondaryMagenta,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Personalizza la tua esperienza arcade',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              NeonCard(
                glowColor: AppTheme.secondaryMagenta,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.tune_rounded,
                          color: AppTheme.secondaryMagenta,
                          size: 32,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Impostazioni Audio & Video',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildSettingsTile(
                      context,
                      title: 'Latenza Audio (Offset)',
                      subtitle: 'Regola la sincronizzazione delle note (ms)',
                      trailing: Text(
                        '0 ms',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.secondaryMagenta,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(color: AppTheme.borderSubtle, height: 24),
                    _buildSettingsTile(
                      context,
                      title: 'Dimensione Note',
                      subtitle: 'Dimensione dei tasti di gioco sullo schermo',
                      trailing: Text(
                        'Media',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.secondaryMagenta,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(color: AppTheme.borderSubtle, height: 24),
                    _buildSettingsTile(
                      context,
                      title: 'Effetti Glow',
                      subtitle: 'Mostra bagliori neon ad alte prestazioni',
                      trailing: Switch(
                        value: true,
                        onChanged: (val) {},
                        activeColor: AppTheme.secondaryMagenta,
                        activeTrackColor: AppTheme.secondaryMagenta.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              NeonCard(
                glowColor: AppTheme.borderSubtle,
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      color: AppTheme.textSecondary,
                      size: 24,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BeatForge Engine v1.0.0',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Sviluppato in locale con Flutter & Drift SQLite',
                            style: Theme.of(context).textTheme.bodyMedium,
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

  Widget _buildSettingsTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        trailing,
      ],
    );
  }
}
