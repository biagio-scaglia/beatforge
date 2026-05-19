import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:beatforge/main.dart';

void main() {
  setUpAll(() {
    // Disattiva il caricamento dinamico dei font remoti durante i test locali per evitare errori di rete
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('BeatForge smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BeatForgeApp());

    // Verifica che l'interfaccia iniziale mostri correttamente il titolo principale con effetto neon
    expect(find.text('BEATFORGE'), findsOneWidget);
  });
}
