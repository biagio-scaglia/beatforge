import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/theme/app_tokens.dart';
import '../../../../shared/widgets/glow_text.dart';
import '../../../../shared/services/audio_player_service_provider.dart';
import '../../../../shared/widgets/beatchan_sprite.dart';
import '../../../../shared/widgets/neon_button.dart';
import '../beatmap_editor_controller.dart';

/// Pannello laterale (o inferiore) per visualizzare e modificare le proprietà delle note,
/// oltre ad impostare le opzioni di snap, zoom e strumenti di inserimento predefiniti.
class NoteDetailsPanel extends StatelessWidget {
  const NoteDetailsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTokens.radiusMd),
        border: Border.all(color: AppTheme.borderSubtle),
      ),
      padding: const EdgeInsets.all(AppTokens.spacingMd),
      child: Consumer<BeatmapEditorController>(
        builder: (context, controller, child) {
          final note = controller.selectedNote;

          if (note == null) {
            return _buildToolConfigPanel(context, controller);
          }

          return _buildNoteEditorPanel(context, controller, note);
        },
      ),
    );
  }

  /// Visualizzazione delle impostazioni dell'editor quando nessuna nota è selezionata.
  Widget _buildToolConfigPanel(
    BuildContext context,
    BeatmapEditorController controller,
  ) {
    final playerService = AudioPlayerServiceProvider.of(context, listen: false);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GlowText(
            'CONFIGURAZIONE UTENSILI',
            glowColor: AppTheme.primaryCyan,
            style: TextStyle(
              fontFamily: 'Orbitron',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryCyan,
            ),
          ),
          const SizedBox(height: AppTokens.spacingMd),

          // Zoom slider
          const Text(
            'Zoom della Timeline',
            style: TextStyle(color: AppTheme.textSecondary, fontSize: 11),
          ),
          Row(
            children: [
              const Icon(
                Icons.zoom_out,
                size: 16,
                color: AppTheme.textSecondary,
              ),
              Expanded(
                child: Slider(
                  value: controller.zoom,
                  min: 0.05,
                  max: 0.8,
                  activeColor: AppTheme.primaryCyan,
                  inactiveColor: AppTheme.borderSubtle,
                  onChanged: (val) => controller.zoom = val,
                ),
              ),
              const Icon(Icons.zoom_in, size: 16, color: AppTheme.primaryCyan),
            ],
          ),
          const SizedBox(height: AppTokens.spacingMd),

          // Grid Snap selector
          const Text(
            'Griglia Ritmica (Snap)',
            style: TextStyle(color: AppTheme.textSecondary, fontSize: 11),
          ),
          const SizedBox(height: 8),
          SegmentedButton<int>(
            style: _segmentedButtonStyle(),
            segments: const [
              ButtonSegment<int>(
                value: 0,
                label: Text('None', style: TextStyle(fontSize: 10)),
              ),
              ButtonSegment<int>(
                value: 1,
                label: Text('1/1', style: TextStyle(fontSize: 10)),
              ),
              ButtonSegment<int>(
                value: 2,
                label: Text('1/2', style: TextStyle(fontSize: 10)),
              ),
              ButtonSegment<int>(
                value: 4,
                label: Text('1/4', style: TextStyle(fontSize: 10)),
              ),
            ],
            selected: {controller.gridSnapDivisor},
            onSelectionChanged: (set) => controller.gridSnapDivisor = set.first,
          ),
          const SizedBox(height: AppTokens.spacingLg),

          // Tool note type insert
          const Text(
            'Tipo Nota da Inserire',
            style: TextStyle(color: AppTheme.textSecondary, fontSize: 11),
          ),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            style: _segmentedButtonStyle(),
            segments: const [
              ButtonSegment<String>(
                value: 'tap',
                label: Text('TAP', style: TextStyle(fontSize: 10)),
                icon: Icon(
                  Icons.circle_outlined,
                  size: 12,
                  color: AppTheme.primaryCyan,
                ),
              ),
              ButtonSegment<String>(
                value: 'hold',
                label: Text('HOLD', style: TextStyle(fontSize: 10)),
                icon: Icon(
                  Icons.linear_scale_rounded,
                  size: 12,
                  color: Colors.orangeAccent,
                ),
              ),
              ButtonSegment<String>(
                value: 'flick',
                label: Text('FLICK', style: TextStyle(fontSize: 10)),
                icon: Icon(
                  Icons.arrow_upward_rounded,
                  size: 12,
                  color: AppTheme.secondaryMagenta,
                ),
              ),
            ],
            selected: {controller.activeNoteType},
            onSelectionChanged: (set) => controller.activeNoteType = set.first,
          ),
          const SizedBox(height: AppTokens.spacingLg),

          const Divider(color: AppTheme.borderSubtle),
          const SizedBox(height: AppTokens.spacingMd),

          const Text(
            'Suggerimenti:\n'
            '• Tocca le corsie della timeline per inserire una nota al tempo corrente della playhead.\n'
            '• Fai drag orizzontale sulla timeline per scorrere rapidamente il brano.\n'
            '• Clicca su una nota esistente per aprirne i dettagli di modifica.',
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 11,
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppTokens.spacingLg),
          const Divider(color: AppTheme.borderSubtle),
          const SizedBox(height: AppTokens.spacingMd),
          Center(
            child: StreamBuilder<bool>(
              stream: playerService.player.playingStream,
              initialData: playerService.player.playing,
              builder: (context, snapshot) {
                final bool isPlaying = snapshot.data ?? false;
                return BeatChanSprite(
                  isPlaying: isPlaying,
                  width: 90,
                  height: 80,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Visualizzazione delle impostazioni della nota quando una di esse viene selezionata.
  Widget _buildNoteEditorPanel(
    BuildContext context,
    BeatmapEditorController controller,
    dynamic note, // BeatmapNote
  ) {
    final textTimeController = TextEditingController(
      text: note.timeMs.toString(),
    );
    final textDurationController = TextEditingController(
      text: (note.durationMs ?? 0).toString(),
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GlowText(
                'DETTAGLI NOTA',
                glowColor: AppTheme.secondaryMagenta,
                style: const TextStyle(
                  fontFamily: 'Orbitron',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.secondaryMagenta,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 18,
                  color: AppTheme.textSecondary,
                ),
                tooltip: 'Deseleziona',
                onPressed: () => controller.selectNote(null),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.spacingMd),

          // ID della nota
          Text(
            'Nota ID: ${note.id < 0 ? 'Nuova (Non Salvata)' : note.id}',
            style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11),
          ),
          const SizedBox(height: AppTokens.spacingMd),

          // Tempo in ms
          const Text(
            'Tempo di attivazione (ms)',
            style: TextStyle(color: AppTheme.textSecondary, fontSize: 11),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.remove,
                  size: 16,
                  color: AppTheme.primaryCyan,
                ),
                onPressed: () =>
                    controller.updateNote(note.id, timeMs: note.timeMs - 50),
              ),
              Expanded(
                child: TextField(
                  controller: textTimeController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 13,
                    fontFamily: 'Consolas',
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    isDense: true,
                  ),
                  onSubmitted: (val) {
                    final int? parsed = int.tryParse(val);
                    if (parsed != null && parsed >= 0) {
                      controller.updateNote(note.id, timeMs: parsed);
                    }
                  },
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.add,
                  size: 16,
                  color: AppTheme.primaryCyan,
                ),
                onPressed: () =>
                    controller.updateNote(note.id, timeMs: note.timeMs + 50),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.spacingMd),

          // Selezione corsia (Lane)
          const Text(
            'Corsia (Lane)',
            style: TextStyle(color: AppTheme.textSecondary, fontSize: 11),
          ),
          const SizedBox(height: 6),
          SegmentedButton<int>(
            style: _segmentedButtonStyle(),
            segments: const [
              ButtonSegment<int>(
                value: 0,
                label: Text('0', style: TextStyle(fontSize: 11)),
              ),
              ButtonSegment<int>(
                value: 1,
                label: Text('1', style: TextStyle(fontSize: 11)),
              ),
              ButtonSegment<int>(
                value: 2,
                label: Text('2', style: TextStyle(fontSize: 11)),
              ),
              ButtonSegment<int>(
                value: 3,
                label: Text('3', style: TextStyle(fontSize: 11)),
              ),
            ],
            selected: {note.lane},
            onSelectionChanged: (set) =>
                controller.updateNote(note.id, lane: set.first),
          ),
          const SizedBox(height: AppTokens.spacingMd),

          // Selezione Tipo Nota
          const Text(
            'Tipo Nota',
            style: TextStyle(color: AppTheme.textSecondary, fontSize: 11),
          ),
          const SizedBox(height: 6),
          SegmentedButton<String>(
            style: _segmentedButtonStyle(),
            segments: const [
              ButtonSegment<String>(
                value: 'tap',
                label: Text('TAP', style: TextStyle(fontSize: 10)),
              ),
              ButtonSegment<String>(
                value: 'hold',
                label: Text('HOLD', style: TextStyle(fontSize: 10)),
              ),
              ButtonSegment<String>(
                value: 'flick',
                label: Text('FLICK', style: TextStyle(fontSize: 10)),
              ),
            ],
            selected: {note.type},
            onSelectionChanged: (set) =>
                controller.updateNote(note.id, type: set.first),
          ),
          const SizedBox(height: AppTokens.spacingMd),

          // Parametri specifici in base al tipo
          if (note.type == 'hold') ...[
            const Text(
              'Durata Hold (ms)',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 11),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.remove,
                    size: 16,
                    color: Colors.orangeAccent,
                  ),
                  onPressed: () {
                    final int currentDur = note.durationMs ?? 0;
                    if (currentDur > 50) {
                      controller.updateNote(
                        note.id,
                        durationMs: currentDur - 50,
                      );
                    }
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: textDurationController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 13,
                      fontFamily: 'Consolas',
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      isDense: true,
                    ),
                    onSubmitted: (val) {
                      final int? parsed = int.tryParse(val);
                      if (parsed != null && parsed >= 0) {
                        controller.updateNote(note.id, durationMs: parsed);
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    size: 16,
                    color: Colors.orangeAccent,
                  ),
                  onPressed: () => controller.updateNote(
                    note.id,
                    durationMs: (note.durationMs ?? 0) + 50,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTokens.spacingMd),
          ] else if (note.type == 'flick') ...[
            const Text(
              'Direzione Flick',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 11),
            ),
            const SizedBox(height: 6),
            SegmentedButton<String>(
              style: _segmentedButtonStyle(),
              segments: const [
                ButtonSegment<String>(
                  value: 'up',
                  label: Text('SU', style: TextStyle(fontSize: 9)),
                  icon: Icon(Icons.arrow_upward_rounded, size: 10),
                ),
                ButtonSegment<String>(
                  value: 'down',
                  label: Text('GIÙ', style: TextStyle(fontSize: 9)),
                  icon: Icon(Icons.arrow_downward_rounded, size: 10),
                ),
                ButtonSegment<String>(
                  value: 'left',
                  label: Text('SX', style: TextStyle(fontSize: 9)),
                  icon: Icon(Icons.arrow_back_rounded, size: 10),
                ),
                ButtonSegment<String>(
                  value: 'right',
                  label: Text('DX', style: TextStyle(fontSize: 9)),
                  icon: Icon(Icons.arrow_forward_rounded, size: 10),
                ),
              ],
              selected: {note.direction ?? 'up'},
              onSelectionChanged: (set) =>
                  controller.updateNote(note.id, direction: set.first),
            ),
            const SizedBox(height: AppTokens.spacingMd),
          ],

          const Divider(color: AppTheme.borderSubtle, height: 32),

          // Delete Note Button
          SizedBox(
            width: double.infinity,
            child: NeonButton(
              text: 'ELIMINA NOTA',
              glowColor: Colors.redAccent,
              onTap: () {
                controller.deleteNote(note.id);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Stile standard per i bottoni segmentati coerente col tema scuro/neon.
  ButtonStyle _segmentedButtonStyle() {
    return SegmentedButton.styleFrom(
      backgroundColor: AppTheme.surfaceElevated,
      foregroundColor: AppTheme.textSecondary,
      selectedBackgroundColor: AppTheme.primaryCyan.withValues(alpha: 0.15),
      selectedForegroundColor: AppTheme.primaryCyan,
      side: const BorderSide(color: AppTheme.borderSubtle),
      padding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}
