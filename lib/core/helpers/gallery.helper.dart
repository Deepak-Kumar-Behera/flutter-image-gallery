import 'dart:typed_data';

import 'package:gal/gal.dart';

class HGallery {
  HGallery._privateConstructor();
  static final HGallery instance = HGallery._privateConstructor();

  Future<bool> requestAccess() {
    return Gal.requestAccess();
  }

  Future<void> saveImageBytes(Uint8List bytes, {String name = 'image'}) {
    return Gal.putImageBytes(bytes, name: name);
  }
}
