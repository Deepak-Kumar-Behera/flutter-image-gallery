import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../../../domain/vms/vm.dart';
import '../../../widgets/widgets.dart';

class GalleryBodyWidget extends ConsumerWidget {
  const GalleryBodyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(galleryViewModelProvider);
    final vm = ref.read(galleryViewModelProvider.notifier);

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = (constraints.maxWidth / 160).floor().clamp(2, 6);

        if (state.isLoading) {
          return ShimmerGridWidget(columns: columns);
        }

        if (state.error != null && state.images.isEmpty) {
          return ErrorViewWidget(message: state.error!, onRetry: vm.refresh);
        }

        if (state.images.isEmpty) {
          return const Center(child: Text('No images found'));
        }

        return LazyLoadScrollView(
          isLoading: state.isLoadingMore,
          onEndOfPage: vm.loadNextPage,
          child: RefreshIndicator(
            onRefresh: () async => await vm.refresh(),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(8),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.8,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => ImageTileWidget(image: state.images[index]),
                      childCount: state.images.length,
                    ),
                  ),
                ),
                if (state.isLoadingMore) const SliverToBoxAdapter(child: PaginationLoaderWidget()),
              ],
            ),
          ),
        );
      },
    );
  }
}
