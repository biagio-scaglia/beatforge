import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_tokens.dart';

/// Applica un effetto visivo di pressione (riduzione di scala) e un feedback
/// aptico selettivo (vibrazione leggera) sui widget interattivi.
///
/// Simula la precisione visiva e la rapidità dei rhythm game (es. Project Sekai).
class TactileFeedback extends StatefulWidget {
  /// Il widget su cui applicare il feedback.
  final Widget child;

  /// Callback da eseguire al rilascio del tocco. Se nullo, il feedback è disabilitato.
  final VoidCallback? onTap;

  /// La percentuale di riduzione della scala durante la pressione (default: 0.96).
  final double scalePressed;

  /// Se attivare o meno il feedback aptico fisico.
  final bool enableHaptic;

  const TactileFeedback({
    super.key,
    required this.child,
    this.onTap,
    this.scalePressed = 0.96,
    this.enableHaptic = true,
  });

  @override
  State<TactileFeedback> createState() => _TactileFeedbackState();
}

class _TactileFeedbackState extends State<TactileFeedback> {
  bool _isPressed = false;

  void _handleTapDown() {
    if (widget.onTap == null) return;
    setState(() => _isPressed = true);
    if (widget.enableHaptic) {
      HapticFeedback.lightImpact();
    }
  }

  void _handleTapUp() {
    if (widget.onTap == null) return;
    setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    if (widget.onTap == null) return;
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _handleTapDown(),
      onTapUp: (_) => _handleTapUp(),
      onTapCancel: () => _handleTapCancel(),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? widget.scalePressed : 1.0,
        duration: AppTokens.durationFast,
        curve: AppTokens.curveInteractive,
        child: widget.child,
      ),
    );
  }
}
