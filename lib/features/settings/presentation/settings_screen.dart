import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/theme/app_tokens.dart';
import '../../../shared/widgets/glow_text.dart';
import '../../../shared/widgets/neon_card.dart';

/// La schermata delle opzioni e impostazioni di BeatForge.
///
/// Consente la configurazione audio-visiva (offset di latenza, dimensioni delle note
/// e attivazione degli effetti neon) salvando le preferenze locali.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _glowEffects = true;
  double _latency = 0.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTokens.spacingLg),
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
              const SizedBox(height: AppTokens.spacingSm),
              Text(
                'Personalizza la tua esperienza arcade',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: AppTokens.spacingLg),
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
                        const SizedBox(width: AppTokens.spacingMd),
                        Expanded(
                          child: Text(
                            'Impostazioni Audio & Video',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTokens.spacingLg),

                    // Slider Latenza con feedback aptico sul cambio di valore discreto
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Latenza Audio (Offset)',
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: AppTokens.spacingMd),
                            Text(
                              '${_latency.toInt()} ms',
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: AppTheme.secondaryMagenta,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Regola la sincronizzazione delle note in base al dispositivo',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Slider(
                          value: _latency,
                          min: -200,
                          max: 200,
                          divisions: 40,
                          activeColor: AppTheme.secondaryMagenta,
                          inactiveColor: AppTheme.borderSubtle,
                          onChanged: (val) {
                            if (val.toInt() != _latency.toInt()) {
                              HapticFeedback.selectionClick();
                            }
                            setState(() {
                              _latency = val;
                            });
                          },
                        ),
                      ],
                    ),
                    const Divider(color: AppTheme.borderSubtle, height: 24),

                    // Switch per effetti grafici
                    _buildSettingsTile(
                      context,
                      title: 'Effetti Glow',
                      subtitle: 'Mostra bagliori neon ad alte prestazioni',
                      trailing: Switch(
                        value: _glowEffects,
                        onChanged: (val) {
                          HapticFeedback.selectionClick();
                          setState(() {
                            _glowEffects = val;
                          });
                        },
                        activeThumbColor: AppTheme.secondaryMagenta,
                        activeTrackColor: AppTheme.secondaryMagenta.withValues(
                          alpha: 0.20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTokens.spacingLg),
              NeonCard(
                glowColor: AppTheme.borderSubtle,
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      color: AppTheme.textSecondary,
                      size: 24,
                    ),
                    const SizedBox(width: AppTokens.spacingMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BeatForge Engine v1.1.0',
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
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
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
        const SizedBox(width: AppTokens.spacingMd),
        trailing,
      ],
    );
  }
}
