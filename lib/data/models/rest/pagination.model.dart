class PaginationModel {
  final int page;
  final int limit;
  final int total;

  const PaginationModel({this.page = 1, this.limit = 20, this.total = 0});

  PaginationModel copyWith({int? page, int? limit, int? total}) {
    return PaginationModel(page: page ?? this.page, limit: limit ?? this.limit, total: total ?? this.total);
  }
}
