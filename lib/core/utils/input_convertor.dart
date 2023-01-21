import 'package:dartz/dartz.dart';
import 'package:number_trivia_app/core/error/failures.dart';

class InputConvertor {
  Either<Failure, int> stringToInt(String str) {
    try {
      final number = int.parse(str);
      if (number < 0) {
        throw const FormatException();
      } else {
        return Right(number);
      }
    } on FormatException {
      return const Left(InvalidInputFailure(''));
    }
  }
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure(super.message);
}
