import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/helpers/helper.dart';
import '../../core/routers/router.dart';
import '../../data/models/model.dart';
import 'favoriteButton.widget.dart';

class ImageTileWidget extends StatelessWidget {
  const ImageTileWidget({super.key, required this.image});

  final PixabayImageModel image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => context.push(RouteName.imageDetail, extra: image),
          child: Hero(
            tag: image.id,
            child: HCacheNetworkImage.getImage(
              url: image.webformatURL,
              borderRadius: 12,
              boxFit: BoxFit.cover,
              memCacheWidth: 320,
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: FavoriteButtonWidget(image: image, iconSize: 18),
        ),
      ],
    );
  }
}
