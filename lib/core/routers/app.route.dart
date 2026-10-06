import 'package:go_router/go_router.dart';

import '../../data/models/model.dart';
import '../../ui/features/feature.dart';
import 'name.route.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteName.gallery,
  routes: <RouteBase>[
    GoRoute(path: RouteName.gallery, builder: (context, state) => const GalleryView()),
    GoRoute(
      path: RouteName.imageDetail,
      builder: (context, state) => ImageDetailView(image: state.extra as PixabayImageModel),
    ),
    GoRoute(path: RouteName.favorites, builder: (context, state) => const FavoritesView()),
  ],
);
