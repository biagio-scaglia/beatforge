import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../home/presentation/home_screen.dart';
import '../../library/presentation/library_screen.dart';
import '../../settings/presentation/settings_screen.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/theme/app_tokens.dart';
import '../../../shared/theme/app_assets.dart';
import '../../../shared/widgets/mini_player.dart';

/// L'involucro di navigazione principale dell'applicazione.
///
/// Adatta il proprio layout in base alla larghezza dello schermo usando i [AppTokens]:
/// - Schermi piccoli: Barra di navigazione inferiore ([NavigationBar]).
/// - Schermi medio-grandi: Barra di navigazione laterale ([NavigationRail]).
///
/// Implementa transizioni a dissolvenza incrociata tra i pannelli ed attiva il
/// feedback aptico di selezione discreta ad ogni cambio scheda.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  void _onTabSelected(int index) {
    if (_currentIndex == index) return;
    setState(() {
      _currentIndex = index;
    });
    // Esegue una vibrazione aptica breve per segnalare visivamente e fisicamente il tocco del tab
    HapticFeedback.selectionClick();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(onNavigateToLibrary: () => _onTabSelected(1)),
      const LibraryScreen(),
      const SettingsScreen(),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        // Breakpoint adattivo basato su token centralizzati
        final bool isMobile =
            constraints.maxWidth < AppTokens.breakpointMobileWide;

        // Visualizzazione della schermata attiva animata
        final Widget currentScreenAnimated = AnimatedSwitcher(
          duration: AppTokens.durationNormal,
          switchInCurve: AppTokens.curveInteractive,
          switchOutCurve: AppTokens.curveDecelerate,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: KeyedSubtree(
            key: ValueKey<int>(_currentIndex),
            child: screens[_currentIndex],
          ),
        );

        if (isMobile) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(child: currentScreenAnimated),
                  const MiniPlayer(),
                ],
              ),
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: _currentIndex,
              onDestinationSelected: _onTabSelected,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'HOME',
                ),
                NavigationDestination(
                  icon: Icon(Icons.library_music_outlined),
                  selectedIcon: Icon(Icons.library_music),
                  label: 'LIBRERIA',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: 'OPZIONI',
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _currentIndex,
                  onDestinationSelected: _onTabSelected,
                  labelType: NavigationRailLabelType.all,
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppTheme.primaryCyan,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primaryCyan.withValues(
                                  alpha: 0.3,
                                ),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              AppAssets.logo,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'BF',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: AppTheme.primaryCyan,
                                fontSize: 12,
                              ),
                        ),
                      ],
                    ),
                  ),
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('HOME'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.library_music_outlined),
                      selectedIcon: Icon(Icons.library_music),
                      label: Text('LIBRERIA'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.settings_outlined),
                      selectedIcon: Icon(Icons.settings),
                      label: Text('OPZIONI'),
                    ),
                  ],
                ),
                const VerticalDivider(
                  thickness: 1,
                  width: 1,
                  color: AppTheme.borderSubtle,
                ),
                Expanded(
                  child: SafeArea(
                    child: Column(
                      children: [
                        Expanded(child: currentScreenAnimated),
                        const MiniPlayer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
