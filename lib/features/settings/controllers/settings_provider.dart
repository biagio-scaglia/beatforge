import 'package:flutter/widgets.dart';
import 'settings_controller.dart';

/// Provider basato su [InheritedWidget] per esporre [SettingsController] all'albero dei widget.
class SettingsProvider extends InheritedWidget {
  final SettingsController controller;

  const SettingsProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  /// Ottiene l'istanza del [SettingsController].
  /// Se `listen` è true, il widget chiamante verrà ricostruito al variare delle impostazioni.
  static SettingsController of(BuildContext context, {bool listen = true}) {
    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<SettingsProvider>()
        : context.getInheritedWidgetOfExactType<SettingsProvider>();
    assert(provider != null, 'Nessun SettingsProvider trovato nel context.');
    return provider!.controller;
  }

  @override
  bool updateShouldNotify(SettingsProvider oldWidget) {
    return controller != oldWidget.controller;
  }
}
