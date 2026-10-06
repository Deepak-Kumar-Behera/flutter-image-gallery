import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/model.dart';
import '../../data/providers/provider.dart';
import 'iconBackdrop.widget.dart';

class FavoriteButtonWidget extends ConsumerWidget {
  const FavoriteButtonWidget({super.key, required this.image, this.iconSize});

  final PixabayImageModel image;
  final double? iconSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoritesProvider.select((list) => list.any((e) => e.id == image.id)));

    return IconBackdropWidget(
      child: IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : Colors.white,
        ),
        iconSize: iconSize,
        visualDensity: VisualDensity.compact,
        onPressed: () => ref.read(favoritesProvider.notifier).toggle(image),
      ),
    );
  }
}
