import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_assets.dart';
import '../theme/app_theme.dart';

/// Stati di animazione disponibili per lo sprite.
enum BeatChanSpriteMode {
  /// Animazione rilassata a riposo (alterna 2 frame lentamente)
  idle,

  /// Animazione ritmica rapida (cicla 4 frame velocemente)
  dancing,

  /// Reazione rapida interattiva al tap
  tapped,
}

/// Widget animato interattivo che carica e riproduce lo spritesheet 2x2 di Beat-chan.
///
/// Lo spritesheet ha dimensioni totali di 500x448 pixel, contenendo 4 frame da 250x224 ciascuno.
/// Reagisce allo stato di riproduzione della musica (danza se riprodotta) e al tocco dell'utente,
/// mostrando piccoli messaggi di testo cyberpunk (fumetti d'incoraggiamento).
class BeatChanSprite extends StatefulWidget {
  /// Dimensione orizzontale del widget
  final double width;

  /// Dimensione verticale del widget (mantiene proporzione 250:224)
  final double height;

  /// Stato di riproduzione musicale per attivare la danza
  final bool isPlaying;

  /// Abilita le interazioni al tocco (animazione speciale + fumetto)
  final bool interactive;

  const BeatChanSprite({
    super.key,
    this.width = 90.0,
    this.height = 80.0,
    this.isPlaying = false,
    this.interactive = true,
  });

  @override
  State<BeatChanSprite> createState() => _BeatChanSpriteState();
}

class _BeatChanSpriteState extends State<BeatChanSprite> {
  Timer? _animTimer;
  int _frameIndex = 0;
  BeatChanSpriteMode _mode = BeatChanSpriteMode.idle;
  String? _bubbleText;
  Timer? _bubbleTimer;
  double _scale = 1.0;

  // Frasi motivazionali cyberpunk per il fumetto
  static const List<String> _motivationalPhrases = [
    'Facciamo rumore! 🎶',
    'Tieni il tempo! ⚡',
    'Mappa pazzesca! ⭐',
    'Rhythm Power! 🎸',
    'Perfect! ✨',
    'Tocca a tempo! 🥁',
    'BeatForge rock! 🚀',
    'Keep it up! 🌟',
    'Yeah! 🤘',
  ];

  @override
  void initState() {
    super.initState();
    _updateMode();
    _startAnimation();
  }

  @override
  void didUpdateWidget(covariant BeatChanSprite oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying != oldWidget.isPlaying &&
        _mode != BeatChanSpriteMode.tapped) {
      _updateMode();
      _startAnimation();
    }
  }

  @override
  void dispose() {
    _animTimer?.cancel();
    _bubbleTimer?.cancel();
    super.dispose();
  }

  void _updateMode() {
    _mode = widget.isPlaying
        ? BeatChanSpriteMode.dancing
        : BeatChanSpriteMode.idle;
  }

  void _startAnimation() {
    _animTimer?.cancel();

    Duration duration;
    switch (_mode) {
      case BeatChanSpriteMode.dancing:
        duration = const Duration(milliseconds: 160);
        break;
      case BeatChanSpriteMode.tapped:
        duration = const Duration(milliseconds: 80);
        break;
      case BeatChanSpriteMode.idle:
        duration = const Duration(milliseconds: 380);
        break;
    }

    _animTimer = Timer.periodic(duration, (timer) {
      if (!mounted) return;
      setState(() {
        if (_mode == BeatChanSpriteMode.idle) {
          // A riposo alterna principalmente i primi due frame per simulare il respiro/idle
          _frameIndex = _frameIndex == 0 ? 1 : 0;
        } else if (_mode == BeatChanSpriteMode.dancing) {
          // Durante la riproduzione cicla tutti e 4 i frame in sequenza
          _frameIndex = (_frameIndex + 1) % 4;
        } else if (_mode == BeatChanSpriteMode.tapped) {
          // In modalità tap cicla velocemente
          _frameIndex = (_frameIndex + 1) % 4;
        }
      });
    });
  }

  void _handleTap() {
    if (!widget.interactive || _mode == BeatChanSpriteMode.tapped) return;

    _bubbleTimer?.cancel();
    setState(() {
      _mode = BeatChanSpriteMode.tapped;
      _scale = 1.2; // Effetto rimbalzo visivo
      _bubbleText =
          _motivationalPhrases[Random().nextInt(_motivationalPhrases.length)];
    });
    _startAnimation();

    // Ritorna allo stato originario dopo 480ms (un ciclo rapido completo dei frame)
    Future.delayed(const Duration(milliseconds: 480), () {
      if (!mounted) return;
      setState(() {
        _scale = 1.0;
        _updateMode();
      });
      _startAnimation();
    });

    // Fa sparire il fumetto dopo 1.5 secondi
    _bubbleTimer = Timer(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      setState(() {
        _bubbleText = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calcoliamo colonna e riga nello spritesheet 2x2
    final int col = _frameIndex % 2;
    final int row = _frameIndex ~/ 2;

    Widget spriteWidget = MouseRegion(
      cursor: widget.interactive
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: _handleTap,
        child: AnimatedScale(
          scale: _scale,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOutBack,
          child: ClipRect(
            child: SizedBox(
              width: widget.width,
              height: widget.height,
              child: Align(
                alignment: Alignment(-1.0 + (col * 2.0), -1.0 + (row * 2.0)),
                widthFactor: 0.5,
                heightFactor: 0.5,
                child: Image.asset(
                  AppAssets.beatchanSprite,
                  // L'immagine originale deve essere scalata al doppio per riempire i fattori 0.5
                  width: widget.width * 2,
                  height: widget.height * 2,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (_bubbleText == null) {
      return spriteWidget;
    }

    // Aggiunge il fumetto se presente
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        spriteWidget,
        // Fumetto posizionato sopra lo sprite
        Positioned(
          bottom: widget.height * 0.95,
          child: _SpeechBubble(text: _bubbleText!),
        ),
      ],
    );
  }
}

/// Mini widget interno per disegnare il fumetto di testo con stile cyberpunk.
class _SpeechBubble extends StatelessWidget {
  final String text;

  const _SpeechBubble({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.surfaceElevated.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.primaryCyan.withValues(alpha: 0.8),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryCyan.withValues(alpha: 0.2),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppTheme.textPrimary,
          fontSize: 9.5,
          fontWeight: FontWeight.bold,
          fontFamily: 'Orbitron',
        ),
      ),
    );
  }
}
