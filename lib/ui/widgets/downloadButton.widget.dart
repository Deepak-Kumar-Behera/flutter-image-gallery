import 'package:flutter/material.dart';

import '../../core/apis/api.dart';
import '../../core/helpers/helper.dart';
import 'iconBackdrop.widget.dart';

class DownloadButtonWidget extends StatefulWidget {
  const DownloadButtonWidget({
    super.key,
    required this.imageUrl,
    this.fileName = 'image',
  });

  final String imageUrl;
  final String fileName;

  @override
  State<DownloadButtonWidget> createState() => _DownloadButtonWidgetState();
}

class _DownloadButtonWidgetState extends State<DownloadButtonWidget> {
  bool _downloading = false;

  Future<void> _download() async {
    setState(() => _downloading = true);

    try {
      final hasAccess = await HGallery.instance.requestAccess();
      if (!hasAccess) {
        HSnackBar.instance.error('Gallery access permission denied.');
        return;
      }

      final bytes = await ApiCall.instance.getBytes(widget.imageUrl);
      await HGallery.instance.saveImageBytes(bytes, name: widget.fileName);
      HSnackBar.instance.success('Image saved to gallery.');
    } catch (e) {
      HLogger.instance.logError(e);
      HSnackBar.instance.error('Failed to download image.');
    } finally {
      if (mounted) setState(() => _downloading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_downloading) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
        ),
      );
    }

    return IconBackdropWidget(
      child: IconButton(
        icon: Icon(Icons.file_download_outlined, color: Colors.white),
        visualDensity: VisualDensity.compact,
        onPressed: _download,
      ),
    );
  }
}
