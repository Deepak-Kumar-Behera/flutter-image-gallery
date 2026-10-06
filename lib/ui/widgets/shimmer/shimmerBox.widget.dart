import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/extensions/extension.dart';

class ShimmerBoxWidget extends StatelessWidget {
  const ShimmerBoxWidget({super.key, this.width, this.height = 14, this.borderRadius = 8});

  final double? width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Shimmer.fromColors(
      baseColor: colors.surfaceContainerHighest,
      highlightColor: colors.surface,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: colors.surfaceContainer,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
