import 'package:flutter/material.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/theme/app_tokens.dart';
import '../../../shared/widgets/glow_text.dart';
import '../../../shared/widgets/neon_button.dart';
import '../../../shared/widgets/neon_list_tile.dart';

/// La schermata per la gestione della libreria musicale dei beatmap locali.
///
/// Consente la ricerca, il filtraggio e l'avvio delle mappe beat caricate
/// all'interno del database.
class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  String _activeFilter = 'TUTTI';

  // Dati finti rappresentativi delle mappe beat
  final List<Map<String, String>> _sampleSongs = [
    {
      'title': 'Dual Drive',
      'genre': 'Electro Pop',
      'bpm': '145 BPM',
      'difficulty': 'Difficile',
    },
    {
      'title': 'Neon Horizon',
      'genre': 'Synthwave',
      'bpm': '120 BPM',
      'difficulty': 'Normale',
    },
    {
      'title': 'Cyber Resonance',
      'genre': 'Future Core',
      'bpm': '175 BPM',
      'difficulty': 'Estrema',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 850),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTokens.spacingLg),
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
              const SizedBox(height: AppTokens.spacingSm),
              Text(
                'Gestisci ed esporta le tue mappe beat musicali',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: AppTokens.spacingLg),

              // Sezione Filtri di ricerca rapida con pulsanti ad alta responsività
              Wrap(
                spacing: AppTokens.spacingSm,
                runSpacing: AppTokens.spacingSm,
                children: ['TUTTI', 'PROPRII', 'PREFERITI'].map((filter) {
                  final bool isSelected = _activeFilter == filter;
                  return NeonButton(
                    text: filter,
                    isSecondary: !isSelected,
                    glowColor: isSelected
                        ? AppTheme.primaryCyan
                        : AppTheme.textSecondary,
                    onTap: () {
                      setState(() {
                        _activeFilter = filter;
                      });
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: AppTokens.spacingLg),

              // Lista di brani caricati localmente
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _sampleSongs.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppTokens.spacingMd),
                itemBuilder: (context, index) {
                  final song = _sampleSongs[index];
                  return NeonListTile(
                    title: song['title']!,
                    subtitle:
                        '${song['genre']} • ${song['bpm']} • ${song['difficulty']}',
                    glowColor: index % 2 == 0
                        ? AppTheme.primaryCyan
                        : AppTheme.secondaryMagenta,
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceElevated,
                        borderRadius:
                            BorderRadius.circular(AppTokens.radiusSm),
                        border: Border.all(
                          color: AppTheme.borderSubtle,
                        ),
                      ),
                      child: Icon(
                        Icons.music_note_rounded,
                        color: index % 2 == 0
                            ? AppTheme.primaryCyan
                            : AppTheme.secondaryMagenta,
                      ),
                    ),
                    trailing: NeonButton(
                      text: 'Gioca',
                      glowColor: index % 2 == 0
                          ? AppTheme.primaryCyan
                          : AppTheme.secondaryMagenta,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppTheme.surfaceElevated,
                            content: Text(
                              'Avvio di "${song['title']}" non disponibile in questa demo.',
                              style: TextStyle(
                                color: index % 2 == 0
                                    ? AppTheme.primaryCyan
                                    : AppTheme.secondaryMagenta,
                                fontFamily: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.fontFamily,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
