import 'package:flutter_test/flutter_test.dart';

import 'package:amna_food_industries_mobile_app/core/app/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const AmnaFoodApp());
    expect(find.byType(AmnaFoodApp), findsOneWidget);
  });
}
