import 'package:flutter/widgets.dart';
import 'audio_player_service.dart';

/// Provider basato su [InheritedWidget] per esporre [AudioPlayerService] all'albero dei widget.
class AudioPlayerServiceProvider extends InheritedWidget {
  final AudioPlayerService service;

  const AudioPlayerServiceProvider({
    super.key,
    required this.service,
    required super.child,
  });

  static AudioPlayerService of(BuildContext context, {bool listen = true}) {
    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<AudioPlayerServiceProvider>()
        : context.getInheritedWidgetOfExactType<AudioPlayerServiceProvider>();
    assert(
      provider != null,
      'Nessun AudioPlayerServiceProvider trovato nel context.',
    );
    return provider!.service;
  }

  @override
  bool updateShouldNotify(AudioPlayerServiceProvider oldWidget) {
    return service != oldWidget.service;
  }
}
