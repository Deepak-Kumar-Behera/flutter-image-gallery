import 'package:flutter/material.dart';

import '../../../../core/extensions/extension.dart';
import '../../../../core/utils/util.dart';

class StatWidget extends StatelessWidget {
  const StatWidget({super.key, required this.icon, required this.value});

  final IconData icon;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: context.colors.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(UNumber.compact(value), style: context.textStyles.bodyMedium),
      ],
    );
  }
}
