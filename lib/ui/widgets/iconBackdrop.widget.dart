import 'package:flutter/material.dart';

class IconBackdropWidget extends StatelessWidget {
  const IconBackdropWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.35), shape: BoxShape.circle),
      child: child,
    );
  }
}
