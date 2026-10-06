import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routers/router.dart';
import '../../../../domain/vms/vm.dart';
import '../../../widgets/widgets.dart';
import '../widgets/widgets.dart';

class GalleryView extends ConsumerWidget {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(galleryViewModelProvider.notifier);

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBarWidget(
          title: 'Gallery',
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () => context.push(RouteName.favorites),
            ),
            const ThemeToggleButtonWidget(),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(52),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: InputFieldWidget(
                hintText: 'Search images',
                prefixIcon: const Icon(Icons.search),
                textInputAction: TextInputAction.search,
                onSubmitted: vm.search,
              ),
            ),
          ),
        ),
        body: const GalleryBodyWidget(),
      ),
    );
  }
}
