import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../data/local/database/app_database.dart';
import '../beatmap_editor_controller.dart';

/// Il widget della Timeline che disegna le note e la griglia ritmica.
///
/// Consente l'interazione al tocco/mouse per scorrere la traccia (seek) e
/// per posizionare o selezionare le note ritmiche.
class EditorTimeline extends StatelessWidget {
  const EditorTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BeatmapEditorController>(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;
        final double height = constraints.maxHeight;

        // Posizioniamo la playhead fissa al 20% della larghezza da sinistra
        final double playheadX = width * 0.2;

        return StreamBuilder<Duration>(
          stream: controller.playerService.positionStream,
          initialData: Duration.zero,
          builder: (context, snapshot) {
            final currentMs = snapshot.data?.inMilliseconds ?? 0;

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              // Drag orizzontale per navigare velocemente nella canzone (Seek)
              onHorizontalDragUpdate: (details) {
                if (controller.zoom <= 0) return;
                final double deltaMs = -details.primaryDelta! / controller.zoom;
                final int targetMs = (currentMs + deltaMs).round();

                // Limita il seek alla durata stimata del brano (se disponibile) o comunque >= 0
                controller.playerService.seek(
                  Duration(
                    milliseconds: targetMs.clamp(0, 3600000),
                  ), // max 1 ora
                );
              },
              // Tap per selezionare o inserire note
              onTapDown: (details) {
                final localPos = details.localPosition;
                _handleTap(
                  context,
                  controller,
                  localPos,
                  currentMs,
                  playheadX,
                  height,
                );
              },
              child: CustomPaint(
                size: Size(width, height),
                painter: _TimelinePainter(
                  controller: controller,
                  currentMs: currentMs,
                  playheadX: playheadX,
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Gestisce il tocco sulla timeline per selezionare una nota esistente o inserirne una nuova.
  void _handleTap(
    BuildContext context,
    BeatmapEditorController controller,
    Offset localPos,
    int currentMs,
    double playheadX,
    double timelineHeight,
  ) {
    final double laneHeight = timelineHeight / 4;
    final int clickedLane = (localPos.dy / laneHeight).floor().clamp(0, 3);

    // Calcola il tempo in ms corrispondente alla coordinata X toccata
    final int clickedTimeMs =
        currentMs + ((localPos.dx - playheadX) / controller.zoom).round();

    // 1. Cerca se c'è una nota esistente vicina al punto cliccato (tolleranza: ~20px o ~100ms)
    final double toleranceMs = 25 / controller.zoom; // 25 pixel di tolleranza
    BeatmapNote? clickedNote;
    double minDistance = double.infinity;

    for (final note in controller.notes) {
      if (note.lane == clickedLane) {
        final double distance = (note.timeMs - clickedTimeMs).abs().toDouble();
        if (distance <= toleranceMs && distance < minDistance) {
          clickedNote = note;
          minDistance = distance;
        }
      }
    }

    if (clickedNote != null) {
      // Seleziona la nota cliccata
      controller.selectNote(clickedNote);
    } else {
      // Deseleziona
      controller.selectNote(null);

      // Inserisce una nuova nota snappata alla griglia
      controller.addNote(timeMs: clickedTimeMs, lane: clickedLane);
    }
  }
}

/// Painter personalizzato per il rendering rasterizzato della timeline e delle note.
class _TimelinePainter extends CustomPainter {
  final BeatmapEditorController controller;
  final int currentMs;
  final double playheadX;

  _TimelinePainter({
    required this.controller,
    required this.currentMs,
    required this.playheadX,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;
    final double laneHeight = height / 4;

    // Disegna lo sfondo
    final paintBg = Paint()..color = AppTheme.background;
    canvas.drawRect(Offset.zero & size, paintBg);

    // 1. Disegna le corsie (lane lines)
    final paintLaneDivider = Paint()
      ..color = AppTheme.borderSubtle
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (int i = 1; i < 4; i++) {
      final double y = i * laneHeight;
      canvas.drawLine(Offset(0, y), Offset(width, y), paintLaneDivider);
    }

    // 2. Calcola e disegna la griglia ritmica (Beat Snap Lines)
    final double bpm = controller.beatmap.baseBpm > 0
        ? controller.beatmap.baseBpm
        : 120.0;
    final double beatDurationMs = 60000.0 / bpm;

    // Intervallo di tempo visibile nello schermo
    final int startVisibleMs =
        currentMs - (playheadX / controller.zoom).round();
    final int endVisibleMs =
        currentMs + ((width - playheadX) / controller.zoom).round();

    // Snap unit in ms
    final double snapUnitMs = controller.gridSnapDivisor > 0
        ? beatDurationMs / controller.gridSnapDivisor
        : beatDurationMs; // se 0, disegna i beat principali

    // Trova il primo beat visibile
    int firstBeatIndex = (startVisibleMs / snapUnitMs).floor();
    int lastBeatIndex = (endVisibleMs / snapUnitMs).ceil();

    final paintBeatSolid = Paint()
      ..color = AppTheme.primaryCyan.withValues(alpha: 0.3)
      ..strokeWidth = 1.5;

    final paintBeatSub = Paint()
      ..color = AppTheme.primaryCyan.withValues(alpha: 0.1)
      ..strokeWidth = 1.0;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (int i = firstBeatIndex; i <= lastBeatIndex; i++) {
      final int beatTimeMs = (i * snapUnitMs).round();
      if (beatTimeMs < 0) continue;

      final double x = playheadX + (beatTimeMs - currentMs) * controller.zoom;

      // Controlla se è un beat intero (principale) o un sub-beat
      final bool isMainBeat =
          (i %
              (controller.gridSnapDivisor > 0
                  ? controller.gridSnapDivisor
                  : 1)) ==
          0;

      if (isMainBeat) {
        canvas.drawLine(Offset(x, 0), Offset(x, height), paintBeatSolid);

        // Disegna un marker di testo con i secondi / beat index in cima
        if (x >= 0 && x <= width - 30) {
          final double seconds = beatTimeMs / 1000.0;
          textPainter.text = TextSpan(
            text: '${seconds.toStringAsFixed(1)}s',
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 9,
              fontFamily: 'Consolas',
            ),
          );
          textPainter.layout();
          textPainter.paint(canvas, Offset(x + 4, 4));
        }
      } else {
        canvas.drawLine(Offset(x, 0), Offset(x, height), paintBeatSub);
      }
    }

    // 3. Disegna le note
    for (final note in controller.notes) {
      final double noteX =
          playheadX + (note.timeMs - currentMs) * controller.zoom;
      final double noteY = (note.lane + 0.5) * laneHeight;

      // Disegna solo se visibile a schermo (con un margine di tolleranza)
      if (noteX < -150 || noteX > width + 150) continue;

      final bool isSelected = controller.selectedNote?.id == note.id;
      _drawNote(canvas, note, noteX, noteY, laneHeight, isSelected);
    }

    // 4. Disegna il cursore corrente (Playhead)
    final paintPlayhead = Paint()
      ..color = Colors.redAccent
      ..strokeWidth = 2.0;

    canvas.drawLine(
      Offset(playheadX, 0),
      Offset(playheadX, height),
      paintPlayhead,
    );

    // Disegna un triangolo in cima al playhead
    final pathTriangle = Path()
      ..moveTo(playheadX - 8, 0)
      ..lineTo(playheadX + 8, 0)
      ..lineTo(playheadX, 10)
      ..close();
    canvas.drawPath(pathTriangle, Paint()..color = Colors.redAccent);
  }

  /// Disegna una singola nota in base al suo tipo.
  void _drawNote(
    Canvas canvas,
    BeatmapNote note,
    double x,
    double y,
    double laneHeight,
    bool isSelected,
  ) {
    final double radius = laneHeight * 0.28;

    // Disegna l'ombra neon per evidenziare la nota
    final glowPaint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    final mainPaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    Color noteColor;
    if (note.type == 'hold') {
      noteColor = Colors.orangeAccent;
    } else if (note.type == 'flick') {
      noteColor = AppTheme.secondaryMagenta;
    } else {
      noteColor = AppTheme.primaryCyan;
    }

    // Se è selezionata, applichiamo un effetto overlay luminoso
    if (isSelected) {
      final selectRing = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5;
      canvas.drawCircle(Offset(x, y), radius + 4, selectRing);
    }

    // 1. Rendering per nota HOLD (disegna prima la scia di durata)
    if (note.type == 'hold' &&
        note.durationMs != null &&
        note.durationMs! > 0) {
      final double endX = x + note.durationMs! * controller.zoom;

      final sciaPaint = Paint()
        ..color = Colors.orangeAccent.withValues(alpha: 0.25)
        ..style = PaintingStyle.fill;

      final sciaBorder = Paint()
        ..color = Colors.orangeAccent.withValues(alpha: 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      final RRect holdBar = RRect.fromLTRBR(
        x,
        y - radius * 0.5,
        endX,
        y + radius * 0.5,
        Radius.circular(radius * 0.25),
      );

      canvas.drawRRect(holdBar, sciaPaint);
      canvas.drawRRect(holdBar, sciaBorder);

      // Disegna il marker finale della hold
      final endPaint = Paint()
        ..color = Colors.orange.shade800
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(endX, y), radius * 0.8, endPaint);

      final endBorder = Paint()
        ..color = Colors.white70
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;
      canvas.drawCircle(Offset(endX, y), radius * 0.8, endBorder);
    }

    // 2. Disegna il corpo principale della nota
    glowPaint.color = noteColor.withValues(alpha: 0.5);
    mainPaint.color = noteColor;

    canvas.drawCircle(Offset(x, y), radius, glowPaint);
    canvas.drawCircle(Offset(x, y), radius, mainPaint);

    // Disegna l'interno del cerchio in bianco sfumato (stile arcade core)
    final innerPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.8)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(x, y), radius * 0.4, innerPaint);

    // 3. Rendering aggiuntivo per nota FLICK (disegna una freccia direzionale)
    if (note.type == 'flick') {
      final arrowPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round;

      final String dir = note.direction ?? 'up';
      double angle = 0;
      if (dir == 'down') angle = math.pi;
      if (dir == 'left') angle = -math.pi / 2;
      if (dir == 'right') angle = math.pi / 2;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(angle);

      // Disegna una freccia puntata verso l'alto
      canvas.drawLine(const Offset(0, 4), const Offset(0, -7), arrowPaint);
      canvas.drawLine(const Offset(-4, -3), const Offset(0, -7), arrowPaint);
      canvas.drawLine(const Offset(4, -3), const Offset(0, -7), arrowPaint);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _TimelinePainter oldDelegate) {
    return oldDelegate.currentMs != currentMs ||
        oldDelegate.controller.zoom != controller.zoom ||
        oldDelegate.controller.notes.length != controller.notes.length ||
        oldDelegate.controller.selectedNote != controller.selectedNote ||
        oldDelegate.controller.gridSnapDivisor != controller.gridSnapDivisor;
  }
}
