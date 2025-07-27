import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/components/PosesTable.dart';

void main() {
  group('SavedPosesTable Widget Tests', () {
    late List<Map<String, dynamic>> testPoses;
    late Function(Map<String, dynamic>) onApply;
    late Function(String) onDelete;
    late bool applyCalled;
    late bool deleteCalled;
    late String deletedId;

    setUp(() {
      applyCalled = false;
      deleteCalled = false;
      deletedId = '';

      testPoses = [
        {
          'id': '1',
          'name': 'Home Pose',
          'motor1': 90.0,
          'motor2': 90.0,
          'motor3': 90.0,
          'motor4': 90.0,
          'motor5': 90.0,
        },
        {
          'id': '2',
          'name': 'Extended Pose',
          'motor1': 180.0,
          'motor2': 180.0,
          'motor3': 180.0,
          'motor4': 180.0,
          'motor5': 180.0,
        },
      ];

      onApply = (pose) {
        applyCalled = true;
      };

      onDelete = (id) {
        deleteCalled = true;
        deletedId = id;
      };
    });

    Future<void> pumpTable(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 1200, // Increased width to accommodate full table
                height: 800, // Increased height
                child: SavedPosesTable(
                  poses: testPoses,
                  onApply: onApply,
                  onDelete: onDelete,
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
    }

    testWidgets('Renders basic structure', (WidgetTester tester) async {
      await pumpTable(tester);
      expect(find.text('Saved Poses'), findsOneWidget);
      expect(find.byType(DataTable), findsOneWidget);
    });

    testWidgets('Calls onApply when play button pressed', (
      WidgetTester tester,
    ) async {
      await pumpTable(tester);

      // Find the first play button and ensure it's visible
      final playButtons = find.byIcon(Icons.play_arrow);
      expect(playButtons, findsWidgets);

      // Get the center of the first visible play button
      final firstPlayButton = playButtons.first;
      await tester.ensureVisible(firstPlayButton);
      await tester.pumpAndSettle();

      await tester.tap(firstPlayButton, warnIfMissed: false);
      await tester.pump();

      expect(applyCalled, isTrue);
    });

    testWidgets('Calls onDelete when delete button pressed', (
      WidgetTester tester,
    ) async {
      await pumpTable(tester);

      // Find the first delete button and ensure it's visible
      final deleteButtons = find.byIcon(Icons.delete);
      expect(deleteButtons, findsWidgets);

      // Get the center of the first visible delete button
      final firstDeleteButton = deleteButtons.first;
      await tester.ensureVisible(firstDeleteButton);
      await tester.pumpAndSettle();

      await tester.tap(firstDeleteButton, warnIfMissed: false);
      await tester.pump();

      expect(deleteCalled, isTrue);
      expect(deletedId, equals('1'));
    });

    testWidgets('Displays all pose data correctly', (
      WidgetTester tester,
    ) async {
      await pumpTable(tester);

      // Scroll horizontally to ensure all content is visible
      final scrollable = find.byType(SingleChildScrollView);
      await tester.drag(scrollable, const Offset(-500, 0));
      await tester.pumpAndSettle();

      expect(find.text('Home Pose'), findsOneWidget);
      expect(find.text('Extended Pose'), findsOneWidget);
      expect(find.text('90.0'), findsNWidgets(5));
      expect(find.text('180.0'), findsNWidgets(5));
    });
  });
}
