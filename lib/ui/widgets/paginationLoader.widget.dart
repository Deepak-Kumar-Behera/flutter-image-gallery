import 'package:flutter/cupertino.dart';
import '../../core/extensions/extension.dart';

class PaginationLoaderWidget extends StatelessWidget {
  const PaginationLoaderWidget({super.key, this.radius = 14, this.padding = const EdgeInsets.symmetric(vertical: 20)});

  final double radius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: padding,
      child: Center(child: CupertinoActivityIndicator(radius: radius, color: colors.primary)),
    );
  }
}
