import 'package:flutter/material.dart';

import '../../../../core/extensions/extension.dart';
import '../../../../core/helpers/helper.dart';
import '../../../../data/models/model.dart';
import '../../../widgets/widgets.dart';
import '../widgets/widgets.dart';

class ImageDetailView extends StatelessWidget {
  const ImageDetailView({super.key, required this.image});

  final PixabayImageModel image;

  @override
  Widget build(BuildContext context) {
    final tags = image.tags
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();

    return SafeArea(
      top: false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 52,
          leading: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 40,
                height: 40,
                child: IconBackdropWidget(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            FavoriteButtonWidget(image: image),
            const SizedBox(width: 8),
            ShareButtonWidget(
              imageUrl: image.largeImageURL,
              fileName: 'pixabay_${image.id}',
            ),
            const SizedBox(width: 8),
            DownloadButtonWidget(
              imageUrl: image.largeImageURL,
              fileName: 'pixabay_${image.id}',
            ),
            const SizedBox(width: 12),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: image.id,
                child: HCacheNetworkImage.getImage(
                  url: image.webformatURL,
                  width: double.infinity,
                  height: 360,
                  boxFit: BoxFit.cover,
                  memCacheHeight: 720,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          size: 18,
                          color: context.colors.onSurfaceVariant,
                        ),
                        const SizedBox(width: 6),
                        Text(image.user, style: context.textStyles.titleSmall),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 24,
                      runSpacing: 8,
                      children: [
                        StatWidget(
                          icon: Icons.visibility_outlined,
                          value: image.views,
                        ),
                        StatWidget(
                          icon: Icons.favorite_outline,
                          value: image.likes,
                        ),
                        StatWidget(
                          icon: Icons.download_outlined,
                          value: image.downloads,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Tags',
                      style: context.textStyles.labelMedium?.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: tags
                          .map((tag) => TagPillWidget(label: tag))
                          .toList(),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
