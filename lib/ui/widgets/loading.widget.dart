import '../../core/extensions/extension.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.message,
    this.size = 32,
    this.strokeWidth = 3,
    this.padding = const EdgeInsets.all(24),
  });

  final String? message;
  final double size;
  final double strokeWidth;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: strokeWidth,
              color: colors.primary,
              backgroundColor: colors.primaryContainer,
            ),
          ),
          if (message != null) ...<Widget>[
            const SizedBox(height: 12),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: context.textStyles.bodySmall?.copyWith(
                color: colors.onSurfaceVariant,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
