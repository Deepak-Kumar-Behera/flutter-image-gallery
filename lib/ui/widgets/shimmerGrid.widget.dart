import 'package:flutter/material.dart';

import 'shimmer/shimmer.dart';

class ShimmerGridWidget extends StatelessWidget {
  const ShimmerGridWidget({super.key, required this.columns});

  final int columns;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.8,
      ),
      itemCount: columns * 4,
      itemBuilder: (context, index) => const ShimmerBoxWidget(height: double.infinity, borderRadius: 12),
    );
  }
}
