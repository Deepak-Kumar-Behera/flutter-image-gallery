import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:template/ui/features/imageDetail/widgets/widgets.dart';

void main() {
  testWidgets('StatWidget shows a compacted count next to its icon', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: StatWidget(icon: Icons.visibility_outlined, value: 1500)),
      ),
    );

    expect(find.text('1.5k'), findsOneWidget);
    expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
  });

  testWidgets('TagPillWidget shows its label', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: TagPillWidget(label: 'nature'))),
    );

    expect(find.text('nature'), findsOneWidget);
  });
}
