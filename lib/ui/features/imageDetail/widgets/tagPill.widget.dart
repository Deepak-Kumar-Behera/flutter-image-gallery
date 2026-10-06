import 'package:flutter/material.dart';

import '../../../../core/extensions/extension.dart';

class TagPillWidget extends StatelessWidget {
  const TagPillWidget({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: colors.surfaceContainerHighest, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: context.textStyles.labelMedium?.copyWith(color: colors.onSurfaceVariant)),
    );
  }
}
