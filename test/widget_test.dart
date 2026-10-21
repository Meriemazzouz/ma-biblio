import 'package:flutter_test/flutter_test.dart';
import 'package:tp_listes_et_grilles/main.dart';

void main() {
  testWidgets("L'application démarre", (WidgetTester tester) async {
    await tester.pumpWidget(const MaBiblioApp());
    expect(find.text('MaBiblio'), findsWidgets);
  });
}
