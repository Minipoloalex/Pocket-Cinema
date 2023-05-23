import 'package:pocket_cinema/model/number_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('simplest format', () {
    expect(0.format(), '0');
    expect(1.format(), '1');
    expect(10.format(), '10');
    expect(100.format(), '100');
    expect(999.format(), '999');
  });
  test('thousands format', (){
    expect(1000.format(), '1.0K');
    expect(10500.format(), '10.5K');
    expect(10000.format(), '10.0K');
    expect(100000.format(), '100K');
    expect(999000.format(), '999K');
  });
  test('millions format', () {
    expect(1100000.format(), '1.1M');
    expect(12000000.format(), '12.0M');
    expect(100000000.format(), '100.0M');
    expect(999900000.format(), '999.9M');
  });
  test('billions format', (){
    expect(1000000000.format(), '1.0B');
    expect(1200000000.format(), '1.2B');
    expect(10900000000.format(), '10.9B');
  });
}
