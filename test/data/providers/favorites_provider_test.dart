import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/core/helpers/helper.dart';
import 'package:template/data/models/model.dart';
import 'package:template/data/providers/provider.dart';

PixabayImageModel _image(int id) => PixabayImageModel(
  id: id,
  previewURL: 'preview$id',
  webformatURL: 'webformat$id',
  largeImageURL: 'large$id',
  tags: 'tag',
  user: 'user',
  views: 1,
  downloads: 1,
  likes: 1,
);

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await HSharedPreferences.instance.init();
  });

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('toggle adds a favorite then removes it again', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final image = _image(1);
    container.read(favoritesProvider.notifier).toggle(image);
    expect(container.read(favoritesProvider).map((e) => e.id), contains(1));

    container.read(favoritesProvider.notifier).toggle(image);
    expect(container.read(favoritesProvider), isEmpty);
  });

  test('favorites persist to shared_preferences and reload in a new container', () {
    final container1 = ProviderContainer();
    container1.read(favoritesProvider.notifier).toggle(_image(7));
    container1.dispose();

    final container2 = ProviderContainer();
    addTearDown(container2.dispose);
    expect(container2.read(favoritesProvider).single.id, 7);
  });
}
