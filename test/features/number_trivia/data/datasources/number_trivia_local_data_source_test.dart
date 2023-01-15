import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_app/core/constants/app_constants.dart';
import 'package:number_trivia_app/core/error/exceptions.dart';
import 'package:number_trivia_app/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia_app/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../mocks/mocks.dart';

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late NumberTriviaLocalDataSourceImpl dataSourceImpl;

  final tNumberTriviaModel =
      NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSourceImpl = NumberTriviaLocalDataSourceImpl(mockSharedPreferences);
  });

  group('get last number trivia', () {
    test('should return NumberTrivia from local storage', () async {
      when(() => mockSharedPreferences.getString(any()))
          .thenReturn(fixture('trivia_cached.json'));

      final result = await dataSourceImpl.getLastNumberTrivia();

      verify(
          () => mockSharedPreferences.getString(AppConstants.numberTriviaKey));
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw CacheException when no value present in local storage',
        () async {
      when(() => mockSharedPreferences.getString(any())).thenReturn(null);

      final call = dataSourceImpl.getLastNumberTrivia;

      expect(call, throwsA(const TypeMatcher<CacheException>()));
      verify(
          () => mockSharedPreferences.getString(AppConstants.numberTriviaKey));
    });
  });

  group('cache number trivia', () {
    test('should call SharedPreferences to cache data', () async {
      when(() => mockSharedPreferences.setString(
          AppConstants.numberTriviaKey, any())).thenAnswer((_) async => true);

      await dataSourceImpl.cacheNumberTrivia(tNumberTriviaModel);

      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());

      verify(() => mockSharedPreferences.setString(
            AppConstants.numberTriviaKey,
            expectedJsonString,
          ));
    });
  });
}
