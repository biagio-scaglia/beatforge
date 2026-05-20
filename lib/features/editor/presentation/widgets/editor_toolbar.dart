import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/theme/app_tokens.dart';
import '../../../../shared/widgets/glow_text.dart';
import '../../../../shared/widgets/neon_button.dart';
import '../../../../shared/widgets/beatforge_loader.dart';
import '../beatmap_editor_controller.dart';

/// La barra superiore dell'editor.
///
/// Espone il titolo del brano e della beatmap corrente, lo stato di salvataggio (se ci sono modifiche pendenti)
/// e il bottone per salvare le modifiche nel database SQLite via Drift.
class EditorToolbar extends StatelessWidget implements PreferredSizeWidget {
  const EditorToolbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BeatmapEditorController>(context);

    return Container(
      height: preferredSize.height,
      decoration: const BoxDecoration(
        color: AppTheme.background,
        border: Border(
          bottom: BorderSide(color: AppTheme.borderSubtle, width: 1.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppTokens.spacingMd),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Bottone Back (con gestione modifiche non salvate)
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppTheme.textPrimary,
            ),
            tooltip: 'Torna indietro',
            onPressed: () => _handleBackNavigation(context, controller),
          ),

          // Titolo Beatmap e Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTokens.spacingMd,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: GlowText(
                          controller.beatmap.title.toUpperCase(),
                          glowColor: AppTheme.primaryCyan,
                          style: const TextStyle(
                            fontFamily: 'Orbitron',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryCyan,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.secondaryMagenta.withValues(
                            alpha: 0.15,
                          ),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: AppTheme.secondaryMagenta,
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          'LV.${controller.beatmap.difficultyLevel ?? 0} [${controller.beatmap.difficultyName}]',
                          style: const TextStyle(
                            color: AppTheme.secondaryMagenta,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Orbitron',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    controller.track.displayName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Stato di modifica e Bottone Salva
          Row(
            children: [
              if (controller.isDirty)
                Container(
                  margin: const EdgeInsets.only(right: AppTokens.spacingMd),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTokens.radiusSm),
                    border: Border.all(
                      color: Colors.amber.withValues(alpha: 0.5),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.edit_note_rounded,
                        color: Colors.amber,
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Modifiche non salvate',
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              controller.isSaving
                  ? const SizedBox(
                      width: 32,
                      height: 24,
                      child: BeatForgeLoader(
                        height: 16,
                        width: 32,
                        barWidth: 2,
                      ),
                    )
                  : NeonButton(
                      text: 'SALVA',
                      glowColor: controller.isDirty
                          ? AppTheme.primaryCyan
                          : Colors.grey,
                      onTap: controller.isDirty
                          ? () async {
                              try {
                                await controller.save();
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: AppTheme.surfaceElevated,
                                      content: Text(
                                        'Beatmap salvata con successo!',
                                        style: TextStyle(
                                          color: AppTheme.primaryCyan,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: AppTheme.surfaceElevated,
                                      content: Text(
                                        'Errore durante il salvataggio.',
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }
                            }
                          : () {}, // no-op se non modificato
                    ),
            ],
          ),
        ],
      ),
    );
  }

  /// Gestisce il ritorno indietro dell'utente.
  /// Se vi sono modifiche non salvate, mostra un dialog di avviso per chiedere conferma.
  Future<void> _handleBackNavigation(
    BuildContext context,
    BeatmapEditorController controller,
  ) async {
    if (!controller.isDirty) {
      Navigator.of(context).pop();
      return;
    }

    final bool? discard = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppTheme.surfaceElevated,
          title: const Text('Modifiche non salvate'),
          content: const Text(
            'Hai delle modifiche non salvate sulla beatmap. Vuoi davvero uscire e scartarle?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text(
                'Annulla',
                style: TextStyle(color: AppTheme.textSecondary),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent.withValues(alpha: 0.2),
                side: const BorderSide(color: Colors.redAccent),
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text(
                'Esci e scarta',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        );
      },
    );

    if (discard == true && context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
