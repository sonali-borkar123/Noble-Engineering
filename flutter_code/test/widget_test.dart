import 'package:flutter_test/flutter_test.dart';

import 'package:noble_engineering/main.dart';

void main() {
  testWidgets('App renders home page smoke test',
      (WidgetTester tester) async {
    await tester.pumpWidget(const NobleEngineeringApp());
    await tester.pump();

    // Hero heading and navbar brand render.
    expect(find.textContaining('NOBLE'), findsWidgets);
    expect(find.text('OUR PRODUCTS'), findsOneWidget);
  });
}
