import 'package:flutter/material.dart';
import 'package:flutter_application/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Hello Wold Test", (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(Container), findsOneWidget);
    expect(find.text("Hello world"), findsOneWidget);
  });
}
