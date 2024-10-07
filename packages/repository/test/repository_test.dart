import 'package:test/test.dart';

void main() {
  test('絶対に成功する足し算のテスト', () {
    expect(add(1, 1), 2);
  });
}

int add(int a, int b) {
  return a + b;
}
