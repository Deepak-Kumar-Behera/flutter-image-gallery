import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/apis/api.dart';
import '../../core/helpers/helper.dart';
import 'iconBackdrop.widget.dart';

class ShareButtonWidget extends StatefulWidget {
  const ShareButtonWidget({super.key, required this.imageUrl, this.fileName = 'image'});

  final String imageUrl;
  final String fileName;

  @override
  State<ShareButtonWidget> createState() => _ShareButtonWidgetState();
}

class _ShareButtonWidgetState extends State<ShareButtonWidget> {
  bool _sharing = false;

  Future<void> _share() async {
    setState(() => _sharing = true);

    try {
      final bytes = await ApiCall.instance.getBytes(widget.imageUrl);
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/${widget.fileName}.jpg');
      await file.writeAsBytes(bytes);

      await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
    } catch (e) {
      HLogger.instance.logError(e);
      HSnackBar.instance.error('Failed to share image.');
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_sharing) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
        ),
      );
    }

    return IconBackdropWidget(
      child: IconButton(
        icon: const Icon(Icons.share_outlined, color: Colors.white),
        visualDensity: VisualDensity.compact,
        onPressed: _share,
      ),
    );
  }
}
