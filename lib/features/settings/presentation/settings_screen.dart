import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/theme/app_tokens.dart';
import '../../../shared/widgets/glow_text.dart';
import '../../../shared/widgets/neon_card.dart';
import '../controllers/settings_provider.dart';

/// La schermata delle opzioni e impostazioni di BeatForge.
///
/// Consente la configurazione audio-visiva, le preferenze di gioco e
/// salva tutto localmente tramite `SettingsProvider` (SharedPreferences).
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SettingsProvider.of(context);

    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
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

                  // Sezione Gameplay
                  _buildSectionCard(
                    context,
                    title: 'Gameplay',
                    icon: Icons.videogame_asset_rounded,
                    glowColor: AppTheme.primaryCyan,
                    children: [
                      _buildDifficultySelector(context, controller),
                      const Divider(color: AppTheme.borderSubtle, height: 32),
                      _buildSliderTile(
                        context,
                        title: 'Latenza Audio (Offset)',
                        subtitle:
                            'Regola la sincronizzazione delle note in base al dispositivo',
                        value: controller.latencyOffset.toDouble(),
                        min: -200,
                        max: 200,
                        divisions: 40,
                        valueLabel: '${controller.latencyOffset} ms',
                        activeColor: AppTheme.primaryCyan,
                        onChanged: (val) {
                          if (val.toInt() != controller.latencyOffset) {
                            HapticFeedback.selectionClick();
                            controller.setLatencyOffset(val.toInt());
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTokens.spacingLg),

                  // Sezione Audio
                  _buildSectionCard(
                    context,
                    title: 'Audio',
                    icon: Icons.volume_up_rounded,
                    glowColor: AppTheme.secondaryMagenta,
                    children: [
                      _buildSliderTile(
                        context,
                        title: 'Volume Musica',
                        subtitle: 'Livello di riproduzione dei brani musicali',
                        value: controller.musicVolume,
                        min: 0.0,
                        max: 1.0,
                        divisions: 20,
                        valueLabel:
                            '${(controller.musicVolume * 100).toInt()}%',
                        activeColor: AppTheme.secondaryMagenta,
                        onChanged: (val) {
                          controller.setMusicVolume(val);
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildSliderTile(
                        context,
                        title: 'Volume Effetti (SFX)',
                        subtitle: 'Volume dei suoni di sistema e feedback tap',
                        value: controller.sfxVolume,
                        min: 0.0,
                        max: 1.0,
                        divisions: 20,
                        valueLabel: '${(controller.sfxVolume * 100).toInt()}%',
                        activeColor: AppTheme.secondaryMagenta,
                        onChanged: (val) {
                          controller.setSfxVolume(val);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTokens.spacingLg),

                  // Sezione Aspetto (UI)
                  _buildSectionCard(
                    context,
                    title: 'Aspetto (UI)',
                    icon: Icons.palette_rounded,
                    glowColor: Colors.amberAccent,
                    children: [
                      _buildSettingsTile(
                        context,
                        title: 'Effetti Glow',
                        subtitle: 'Mostra bagliori neon ad alte prestazioni',
                        trailing: Switch(
                          value: controller.glowEffects,
                          onChanged: (val) {
                            HapticFeedback.selectionClick();
                            controller.setGlowEffects(val);
                          },
                          activeThumbColor: Colors.amberAccent,
                          activeTrackColor: Colors.amberAccent.withValues(
                            alpha: 0.20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTokens.spacingLg),

                  // Sezione Libreria Locale
                  _buildSectionCard(
                    context,
                    title: 'Libreria Locale',
                    icon: Icons.library_music_rounded,
                    glowColor: Colors.greenAccent,
                    children: [
                      _buildDropdownTile(
                        context,
                        title: 'Ordinamento Predefinito',
                        subtitle:
                            'Come visualizzare i brani nella libreria al riavvio',
                        currentValue: controller.librarySort,
                        options: const ['Title', 'Date', 'Artist'],
                        labels: const ['Titolo', 'Data Aggiunta', 'Artista'],
                        onChanged: (val) {
                          if (val != null) {
                            HapticFeedback.selectionClick();
                            controller.setLibrarySort(val);
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTokens.spacingXl),

                  // Sezione Info
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
                                'BeatForge Engine v1.2.0',
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
                  const SizedBox(height: AppTokens.spacingXl),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color glowColor,
    required List<Widget> children,
  }) {
    return NeonCard(
      glowColor: glowColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: glowColor, size: 28),
              const SizedBox(width: AppTokens.spacingMd),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.spacingLg),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDifficultySelector(BuildContext context, dynamic controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Difficoltà Predefinita',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          'Imposta il livello predefinito per le beatmap generate o giocate',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'Easy', label: Text('Easy')),
              ButtonSegment(value: 'Normal', label: Text('Normal')),
              ButtonSegment(value: 'Hard', label: Text('Hard')),
              ButtonSegment(value: 'Expert', label: Text('Expert')),
            ],
            selected: {controller.defaultDifficulty},
            onSelectionChanged: (Set<String> newSelection) {
              HapticFeedback.selectionClick();
              controller.setDefaultDifficulty(newSelection.first);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.selected)) {
                  return AppTheme.primaryCyan.withValues(alpha: 0.2);
                }
                return Colors.transparent;
              }),
              foregroundColor: WidgetStateProperty.resolveWith<Color>((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.selected)) {
                  return AppTheme.primaryCyan;
                }
                return AppTheme.textSecondary;
              }),
              side: const WidgetStatePropertyAll(
                BorderSide(color: AppTheme.borderSubtle),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSliderTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required String valueLabel,
    required Color activeColor,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: AppTokens.spacingMd),
            Text(
              valueLabel,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: activeColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          activeColor: activeColor,
          inactiveColor: AppTheme.borderSubtle,
          onChanged: onChanged,
        ),
      ],
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

  Widget _buildDropdownTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String currentValue,
    required List<String> options,
    required List<String> labels,
    required ValueChanged<String?> onChanged,
  }) {
    // Usiamo LayoutBuilder per gestire schermi piccoli dove il testo o il dropdown non ci stanno in riga.
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 400;

        final dropdown = DropdownMenu<String>(
          initialSelection: currentValue,
          onSelected: onChanged,
          textStyle: const TextStyle(color: AppTheme.textPrimary),
          width: isMobile ? double.infinity : 180,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: AppTheme.surfaceElevated.withValues(alpha: 0.5),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppTheme.borderSubtle),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppTheme.primaryCyan),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          dropdownMenuEntries: List.generate(options.length, (index) {
            return DropdownMenuEntry<String>(
              value: options[index],
              label: labels[index],
            );
          }),
        );

        if (isMobile) {
          return Column(
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
              const SizedBox(height: 12),
              dropdown,
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            const SizedBox(width: AppTokens.spacingMd),
            dropdown,
          ],
        );
      },
    );
  }
}
