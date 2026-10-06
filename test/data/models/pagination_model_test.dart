import 'package:flutter_test/flutter_test.dart';
import 'package:template/data/models/model.dart';

void main() {
  test('defaults to page 1, limit 20, total 0', () {
    const pagination = PaginationModel();
    expect(pagination.page, 1);
    expect(pagination.limit, 20);
    expect(pagination.total, 0);
  });

  test('copyWith overrides only the given fields', () {
    const pagination = PaginationModel(page: 1, limit: 20, total: 0);
    final next = pagination.copyWith(page: 2, total: 50);

    expect(next.page, 2);
    expect(next.limit, 20);
    expect(next.total, 50);
  });
}
