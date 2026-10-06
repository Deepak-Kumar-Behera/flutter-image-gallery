import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/providers/provider.dart';
import '../../../widgets/widgets.dart';
import '../widgets/widgets.dart';

class FavoritesView extends ConsumerWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesProvider);

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: const AppBarWidget(title: 'Favorites'),
        body: favorites.isEmpty
            ? const EmptyFavoritesWidget()
            : LayoutBuilder(
                builder: (context, constraints) {
                  final columns = (constraints.maxWidth / 160).floor().clamp(2, 6);

                  return GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: favorites.length,
                    itemBuilder: (context, index) => ImageTileWidget(image: favorites[index]),
                  );
                },
              ),
      ),
    );
  }
}
