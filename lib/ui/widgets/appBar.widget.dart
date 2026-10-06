import 'package:flutter/material.dart';

import '../../core/extensions/extension.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key, required this.title, this.actions, this.bottom});

  final String title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AppBar(
      title: Text(
        title,
        style: context.textStyles.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: colors.onSurface),
      ),
      actions: actions,
      bottom: bottom,
      backgroundColor: colors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      shape: Border(bottom: BorderSide(color: colors.outlineVariant.withValues(alpha: 0.5))),
    );
  }
}
