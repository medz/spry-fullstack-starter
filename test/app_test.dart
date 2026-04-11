import 'package:flutter_test/flutter_test.dart';
import 'package:fullstack_starter/app/app.dart';

void main() {
  testWidgets('builds the app', (tester) async {
    await tester.pumpWidget(const StarterApp());
    await tester.pump();

    expect(find.byType(StarterApp), findsOneWidget);
  }, skip: true);
}
