import 'package:flutter_test/flutter_test.dart';
import 'package:template/core/utils/util.dart';

void main() {
  test('leaves values under 1000 untouched', () {
    expect(UNumber.compact(0), '0');
    expect(UNumber.compact(999), '999');
  });

  test('abbreviates thousands with a k suffix', () {
    expect(UNumber.compact(1000), '1.0k');
    expect(UNumber.compact(1500), '1.5k');
    expect(UNumber.compact(999999), '1000.0k');
  });

  test('abbreviates millions with an M suffix', () {
    expect(UNumber.compact(1000000), '1.0M');
    expect(UNumber.compact(2500000), '2.5M');
  });
}
