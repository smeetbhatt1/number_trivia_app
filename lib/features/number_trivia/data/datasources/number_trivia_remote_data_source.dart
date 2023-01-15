import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:number_trivia_app/core/constants/api_constants.dart';
import 'package:number_trivia_app/core/error/exceptions.dart';
import 'package:number_trivia_app/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl extends NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl(this.client);

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) {
    final uri = Uri.parse('${ApiConstants.baseUrl}/$number');
    return _get(uri);
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    final uri =
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.randomEndpoint}');
    return _get(uri);
  }

  Future<NumberTriviaModel> _get(Uri uri) async {
    final response = await client.get(uri, headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
