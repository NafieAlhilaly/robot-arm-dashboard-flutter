import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/components/StyledButton.dart';

void main() {
  group('StyledButton Widget Tests', () {
    late bool buttonPressed;
    late Widget englishButton;
    late Widget bilingualButton;
    late Widget loadingButton;

    setUp(() {
      buttonPressed = false;

      englishButton = MaterialApp(
        home: Scaffold(
          body: StyledButton(
            text: 'Test',
            onPressed: () {
              buttonPressed = true;
            },
          ),
        ),
      );

      bilingualButton = MaterialApp(
        home: Scaffold(
          body: StyledButton(
            text: 'Test',
            arabicText: 'اختبار',
            isRTL: true,
            onPressed: () {
              buttonPressed = true;
            },
          ),
        ),
      );

      loadingButton = MaterialApp(
        home: Scaffold(
          body: StyledButton(
            text: 'Test',
            onPressed: () {
              buttonPressed = true;
            },
            isLoading: true,
          ),
        ),
      );
    });

    testWidgets('Renders with English text', (WidgetTester tester) async {
      await tester.pumpWidget(englishButton);

      expect(find.text('Test'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Renders with both English and Arabic text', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(bilingualButton);

      expect(find.text('Test'), findsOneWidget);
      expect(find.text('اختبار'), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets('Executes onPressed callback when tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(englishButton);

      await tester.tap(find.byType(StyledButton));
      await tester.pump();

      expect(buttonPressed, isTrue);
    });

    testWidgets('Shows loading indicator when isLoading is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(loadingButton);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Test'), findsNothing);
    });

    testWidgets('Is disabled when isLoading is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(loadingButton);

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('Applies custom styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StyledButton(
              text: 'Test',
              onPressed: () {},
              backgroundColor: Colors.red,
              textColor: Colors.black,
              borderRadius: 20.0,
              padding: const EdgeInsets.all(16),
            ),
          ),
        ),
      );

      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      final style = button.style;

      expect(style?.backgroundColor?.resolve({}), equals(Colors.red));
      expect(style?.foregroundColor?.resolve({}), equals(Colors.black));
      expect(
        (style?.shape?.resolve({}) as RoundedRectangleBorder?)?.borderRadius,
        equals(BorderRadius.circular(20.0)),
      );
      expect(style?.padding?.resolve({}), equals(const EdgeInsets.all(16)));
    });
  });
}
