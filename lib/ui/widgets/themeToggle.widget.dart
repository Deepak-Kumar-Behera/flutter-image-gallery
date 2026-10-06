import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/provider.dart';

class ThemeToggleButtonWidget extends ConsumerWidget {
  const ThemeToggleButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return IconButton(
      icon: Icon(themeMode == ThemeMode.dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
      onPressed: () => ref.read(themeModeProvider.notifier).toggle(),
    );
  }
}
