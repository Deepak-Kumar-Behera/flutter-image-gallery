import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:template/ui/features/favorites/widgets/widgets.dart';

void main() {
  testWidgets('shows the empty-favorites message', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: EmptyFavoritesWidget())));

    expect(find.text('No favorites yet'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
  });
}
