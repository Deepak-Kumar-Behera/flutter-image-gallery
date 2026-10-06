import 'package:flutter/material.dart';

import '../../../../core/extensions/extension.dart';

class EmptyFavoritesWidget extends StatelessWidget {
  const EmptyFavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite_border, size: 48, color: colors.onSurfaceVariant),
            const SizedBox(height: 12),
            Text('No favorites yet', style: textStyles.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Images you favorite will show up here.',
              textAlign: TextAlign.center,
              style: textStyles.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
