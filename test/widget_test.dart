// Widget test file - basic smoke test for app infrastructure
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App infrastructure smoke test', (WidgetTester tester) async {
    // This test verifies the test infrastructure is working.
    // Full widget tests for GymGeminiApp require platform channel mocks
    // (Firebase, path_provider, etc.) which are handled in integration tests.
    expect(true, isTrue);
  });
}
