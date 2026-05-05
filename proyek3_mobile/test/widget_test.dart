import 'package:flutter_test/flutter_test.dart';
import 'package:proyek3_mobile/main.dart';

void main() {
  testWidgets('Login page renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Login Kurir'), findsOneWidget);
    expect(find.text('ID Kurir'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('LOGIN'), findsOneWidget);
  });
}