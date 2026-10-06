import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/helpers/helper.dart';
import '../../data/models/model.dart';
import '../../data/repositories/repository.dart';

class GalleryState {
  final List<PixabayImageModel> images;
  final PaginationModel pagination;
  final String query;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;

  const GalleryState({
    this.images = const [],
    this.pagination = const PaginationModel(),
    this.query = '',
    this.isLoading = true,
    this.isLoadingMore = false,
    this.error,
  });

  bool get hasMore => images.length < pagination.total;

  GalleryState copyWith({
    List<PixabayImageModel>? images,
    PaginationModel? pagination,
    String? query,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
  }) {
    return GalleryState(
      images: images ?? this.images,
      pagination: pagination ?? this.pagination,
      query: query ?? this.query,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
    );
  }
}

class GalleryViewModel extends Notifier<GalleryState> {
  GalleryViewModel({GalleryRepository? repository})
    : _repository = repository ?? const GalleryRepository();

  final GalleryRepository _repository;

  @override
  GalleryState build() {
    Future.microtask(() => _fetch(page: 1));
    return const GalleryState();
  }

  Future<void> refresh() => _fetch(page: 1, query: state.query);

  Future<void> search(String query) => _fetch(page: 1, query: query);

  Future<void> loadNextPage() {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) {
      return Future.value();
    }
    return _fetch(page: state.pagination.page + 1);
  }

  Future<void> _fetch({required int page, String? query}) async {
    final isFirstPage = page == 1;
    state = state.copyWith(
      isLoading: isFirstPage,
      isLoadingMore: !isFirstPage,
      query: query,
      error: null,
    );

    try {
      final (images, total) = await _repository.search(
        query: state.query,
        page: page,
      );
      state = state.copyWith(
        images: isFirstPage ? images : [...state.images, ...images],
        pagination: state.pagination.copyWith(page: page, total: total),
        isLoading: false,
        isLoadingMore: false,
      );
    } catch (e) {
      HLogger.instance.logError(e);
      if (isFirstPage) {
        state = state.copyWith(isLoading: false, error: e.toString());
      } else {
        state = state.copyWith(isLoadingMore: false);
        HSnackBar.instance.error(e.toString());
      }
    }
  }
}

final galleryViewModelProvider =
    NotifierProvider.autoDispose<GalleryViewModel, GalleryState>(
      GalleryViewModel.new,
    );
