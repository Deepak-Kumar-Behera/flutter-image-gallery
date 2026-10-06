import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/consts/const.dart';
import '../../core/helpers/helper.dart';
import '../models/model.dart';

class FavoritesNotifier extends Notifier<List<PixabayImageModel>> {
  @override
  List<PixabayImageModel> build() {
    final raw = HSharedPreferences.instance.getStringList(CStorageKey.favorites) ?? [];
    return raw.map((e) => PixabayImageModel.fromJson(jsonDecode(e))).toList();
  }

  bool isFavorite(int id) => state.any((image) => image.id == id);

  void toggle(PixabayImageModel image) {
    state = isFavorite(image.id) ? state.where((e) => e.id != image.id).toList() : [...state, image];

    HSharedPreferences.instance.setStringList(
      CStorageKey.favorites,
      state.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }
}

final favoritesProvider = NotifierProvider<FavoritesNotifier, List<PixabayImageModel>>(FavoritesNotifier.new);
