import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/data/models/model.dart';
import 'package:template/data/repositories/repository.dart';
import 'package:template/domain/vms/vm.dart';

import '../../helpers/test_helpers.dart';

class MockGalleryRepository extends Mock implements GalleryRepository {}

PixabayImageModel _image(int id) => PixabayImageModel(
  id: id,
  previewURL: 'preview$id',
  webformatURL: 'webformat$id',
  largeImageURL: 'large$id',
  tags: 'tag1, tag2',
  user: 'user$id',
  views: 10,
  downloads: 5,
  likes: 2,
);

void main() {
  setUpAll(mockFluttertoastChannel);

  late MockGalleryRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = MockGalleryRepository();
    container = ProviderContainer(
      overrides: [galleryViewModelProvider.overrideWith(() => GalleryViewModel(repository: repository))],
    );
    addTearDown(container.dispose);
  });

  Future<void> loadFirstPage(List<PixabayImageModel> images, int total) async {
    when(() => repository.search(query: '', page: 1)).thenAnswer((_) async => (images, total));
    container.listen(galleryViewModelProvider, (_, _) {});
    await Future<void>.delayed(Duration.zero);
  }

  test('initial build loads page 1 and marks hasMore when more results exist', () async {
    await loadFirstPage(List.generate(5, _image), 12);

    final state = container.read(galleryViewModelProvider);
    expect(state.isLoading, isFalse);
    expect(state.images.length, 5);
    expect(state.hasMore, isTrue);
    expect(state.error, isNull);
  });

  test('initial build failure sets an error and leaves images empty', () async {
    when(() => repository.search(query: '', page: 1)).thenThrow(Exception('network down'));
    container.listen(galleryViewModelProvider, (_, _) {});
    await Future<void>.delayed(Duration.zero);

    final state = container.read(galleryViewModelProvider);
    expect(state.isLoading, isFalse);
    expect(state.images, isEmpty);
    expect(state.error, isNotNull);
  });

  test('loadNextPage appends results and advances the page', () async {
    await loadFirstPage(List.generate(5, _image), 12);
    when(
      () => repository.search(query: '', page: 2),
    ).thenAnswer((_) async => (List.generate(5, (i) => _image(i + 5)), 12));

    await container.read(galleryViewModelProvider.notifier).loadNextPage();

    final state = container.read(galleryViewModelProvider);
    expect(state.images.length, 10);
    expect(state.pagination.page, 2);
    expect(state.hasMore, isTrue);
  });

  test('loadNextPage is a no-op once hasMore is false', () async {
    await loadFirstPage(List.generate(5, _image), 5);

    await container.read(galleryViewModelProvider.notifier).loadNextPage();

    final state = container.read(galleryViewModelProvider);
    expect(state.images.length, 5);
    expect(state.pagination.page, 1);
    verifyNever(() => repository.search(query: '', page: 2));
  });

  test('loadNextPage failure keeps existing images and clears isLoadingMore', () async {
    await loadFirstPage(List.generate(5, _image), 12);
    when(() => repository.search(query: '', page: 2)).thenThrow(Exception('timeout'));

    await container.read(galleryViewModelProvider.notifier).loadNextPage();

    final state = container.read(galleryViewModelProvider);
    expect(state.images.length, 5);
    expect(state.pagination.page, 1);
    expect(state.isLoadingMore, isFalse);
  });

  test('search resets to page 1 and replaces images under the new query', () async {
    await loadFirstPage(List.generate(5, _image), 12);
    when(() => repository.search(query: 'cats', page: 1)).thenAnswer((_) async => (List.generate(3, _image), 3));

    await container.read(galleryViewModelProvider.notifier).search('cats');

    final state = container.read(galleryViewModelProvider);
    expect(state.images.length, 3);
    expect(state.query, 'cats');
    expect(state.pagination.page, 1);
    expect(state.hasMore, isFalse);
  });
}
