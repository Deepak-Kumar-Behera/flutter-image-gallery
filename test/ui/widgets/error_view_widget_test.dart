import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:template/ui/widgets/widgets.dart';

void main() {
  testWidgets('shows the message and invokes onRetry when tapped', (tester) async {
    var retried = false;

    await tester.pumpWidget(
      MaterialApp(
        home: ErrorViewWidget(
          message: 'Something went wrong',
          onRetry: () async {
            retried = true;
          },
        ),
      ),
    );

    expect(find.text('Something went wrong'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);

    await tester.tap(find.text('Retry'));
    await tester.pump();

    expect(retried, isTrue);
  });
}
