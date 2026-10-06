import 'package:flutter_test/flutter_test.dart';
import 'package:template/data/models/model.dart';

void main() {
  group('PixabayImageModel.fromJson', () {
    test('parses all fields', () {
      final image = PixabayImageModel.fromJson({
        'id': 42,
        'previewURL': 'preview.jpg',
        'webformatURL': 'webformat.jpg',
        'largeImageURL': 'large.jpg',
        'tags': 'cat, animal, pet',
        'user': 'jane',
        'views': 100,
        'downloads': 20,
        'likes': 5,
      });

      expect(image.id, 42);
      expect(image.previewURL, 'preview.jpg');
      expect(image.webformatURL, 'webformat.jpg');
      expect(image.largeImageURL, 'large.jpg');
      expect(image.tags, 'cat, animal, pet');
      expect(image.user, 'jane');
      expect(image.views, 100);
      expect(image.downloads, 20);
      expect(image.likes, 5);
    });

    test('toJson round-trips back to an equivalent model', () {
      final image = PixabayImageModel.fromJson({
        'id': 1,
        'previewURL': 'p',
        'webformatURL': 'w',
        'largeImageURL': 'l',
        'tags': 't',
        'user': 'u',
        'views': 1,
        'downloads': 1,
        'likes': 1,
      });

      final restored = PixabayImageModel.fromJson(image.toJson());
      expect(restored.id, image.id);
      expect(restored.webformatURL, image.webformatURL);
    });
  });

  group('PixabayImageModel.listFromJson', () {
    test('parses hits and total from a search response', () {
      final (images, total) = PixabayImageModel.listFromJson({
        'total': 150,
        'hits': [
          {
            'id': 1,
            'previewURL': 'p1',
            'webformatURL': 'w1',
            'largeImageURL': 'l1',
            'tags': 't',
            'user': 'u',
            'views': 1,
            'downloads': 1,
            'likes': 1,
          },
          {
            'id': 2,
            'previewURL': 'p2',
            'webformatURL': 'w2',
            'largeImageURL': 'l2',
            'tags': 't',
            'user': 'u',
            'views': 1,
            'downloads': 1,
            'likes': 1,
          },
        ],
      });

      expect(total, 150);
      expect(images.map((e) => e.id), [1, 2]);
    });

    test('defaults to an empty list and zero total when fields are missing', () {
      final (images, total) = PixabayImageModel.listFromJson({});

      expect(images, isEmpty);
      expect(total, 0);
    });
  });
}
