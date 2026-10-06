import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:template/ui/widgets/widgets.dart';

void main() {
  testWidgets('clear button appears after typing and resets the field', (tester) async {
    String? submitted;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InputFieldWidget(hintText: 'Search', onSubmitted: (value) => submitted = value),
        ),
      ),
    );

    expect(find.byIcon(Icons.close), findsNothing);

    await tester.enterText(find.byType(TextField), 'cats');
    await tester.pump();

    expect(find.byIcon(Icons.close), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();

    expect(find.text('cats'), findsNothing);
    expect(find.byIcon(Icons.close), findsNothing);
    expect(submitted, '');
  });
}
