// This is a basic Flutter widget test for the Task Manager app.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:task_manager/main.dart';

void main() {
  testWidgets('Task Manager app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Wait for splash screen to finish
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // Verify that we can see the task manager home screen
    expect(find.text('Tasks'), findsOneWidget);
    expect(find.text('No tasks yet!'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('Add task button navigation test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Wait for splash screen to finish
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // Tap the '+' icon to add a task
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify that we navigated to the add task screen
    expect(find.text('Add Task'), findsOneWidget);
    expect(find.text('Title'), findsOneWidget);
    expect(find.text('Due Date'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
    expect(find.text('Select Priority'), findsOneWidget);
  });
}
