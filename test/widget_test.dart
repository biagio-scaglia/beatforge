import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:beatforge/main.dart';
import 'package:beatforge/data/local/database/app_database.dart';
import 'package:beatforge/data/repositories/audio_repository.dart';
import 'package:beatforge/shared/services/audio_player_service.dart';
import 'package:beatforge/shared/services/audio_player_service_provider.dart';

void main() {
  setUpAll(() {
    // Disattiva il caricamento dinamico dei font remoti durante i test locali per evitare errori di rete
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('BeatForge smoke test', (WidgetTester tester) async {
    final database = AppDatabase();
    final repository = AudioRepository(database);
    final playerService = AudioPlayerService();

    await tester.pumpWidget(
      AudioRepositoryProvider(
        repository: repository,
        child: AudioPlayerServiceProvider(
          service: playerService,
          child: const BeatForgeApp(),
        ),
      ),
    );

    // Verifica che l'interfaccia iniziale mostri correttamente il titolo principale con effetto neon
    expect(find.text('BEATFORGE'), findsOneWidget);

    // Rilascia le risorse al termine del test
    await playerService.dispose();
    await database.close();
  });
}
