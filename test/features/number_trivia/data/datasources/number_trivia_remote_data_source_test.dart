import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_app/core/constants/api_constants.dart';
import 'package:number_trivia_app/core/error/exceptions.dart';
import 'package:number_trivia_app/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia_app/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../mocks/mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late NumberTriviaRemoteDataSourceImpl dataSourceImpl;
  const tNumber = 1;
  final tNumberTriviaModel =
      NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourceImpl = NumberTriviaRemoteDataSourceImpl(mockHttpClient);
    registerFallbackValue(FakeUri());
  });

  void mockHttpSuccess() {
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response(
              fixture('trivia.json'),
              200,
            ));
  }

  void mockHttpFailure([int statusCode = 404]) {
    when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response(
              fixture('trivia.json'),
              statusCode,
            ));
  }

  group('get concrete number trivia', () {
    test('should perform a GET request with number being endpoint', () async {
      mockHttpSuccess();

      await dataSourceImpl.getConcreteNumberTrivia(tNumber);

      verify(
        () => mockHttpClient.get(
          Uri.parse('${ApiConstants.baseUrl}/$tNumber'),
          headers: {'Content-Type': 'application/json'},
        ),
      );
    });

    test('should return NumberTrivia when response code is 200', () async {
      mockHttpSuccess();

      final result = await dataSourceImpl.getConcreteNumberTrivia(tNumber);

      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw ServerException when response code is not 200',
        () async {
      mockHttpFailure();

      final call = dataSourceImpl.getConcreteNumberTrivia;

      expect(
          () => call(tNumber), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('get random number trivia', () {
    test('should perform a GET request with number being endpoint', () async {
      mockHttpSuccess();

      await dataSourceImpl.getRandomNumberTrivia();

      verify(
        () => mockHttpClient.get(
          Uri.parse('${ApiConstants.baseUrl}${ApiConstants.randomEndpoint}'),
          headers: {'Content-Type': 'application/json'},
        ),
      );
    });

    test('should return NumberTrivia when response code is 200', () async {
      mockHttpSuccess();

      final result = await dataSourceImpl.getRandomNumberTrivia();

      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw ServerException when response code is not 200',
        () async {
      mockHttpFailure();

      final call = dataSourceImpl.getRandomNumberTrivia;

      expect(call, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
