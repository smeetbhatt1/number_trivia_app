import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_app/core/utils/input_convertor.dart';

void main() {
  final inputConvertor = InputConvertor();

  group('string to int', () {
    test('should convert int to string', () async {
      final result = inputConvertor.stringToInt('123');

      expect(result, const Right(123));
    });

    test('should return failure when string is not integer', () async {
      final result = inputConvertor.stringToInt('abc');

      expect(result, const Left(InvalidInputFailure('')));
    });

    test('should return failure when string is negative integer', () async {
      final result = inputConvertor.stringToInt('-123');

      expect(result, const Left(InvalidInputFailure('')));
    });
  });
}
