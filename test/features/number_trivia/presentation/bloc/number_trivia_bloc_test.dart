import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:number_trivia_app/core/constants/view_text.dart';
import 'package:number_trivia_app/core/error/failures.dart';
import 'package:number_trivia_app/core/utils/input_convertor.dart';
import 'package:number_trivia_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_app/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

import '../../../../mocks/mocks.dart';

void main() {
  late NumberTriviaBloc numberTriviaBloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConvertor mockInputConvertor;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConvertor = MockInputConvertor();

    numberTriviaBloc = NumberTriviaBloc(
      getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
      inputConvertor: mockInputConvertor,
    );
  });

  test('initial state should be empty', () {
    expect(numberTriviaBloc.state, equals(NumberTriviaInitialState()));
  });

  group('get concrete number trivia', () {
    const tNumberString = '1';
    const tNumber = 1;
    const tNumberTrivia = NumberTrivia(text: 'test', number: 1);

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [NumberTriviaLoadingSate, NumberTriviaErrorState] when the input is invalid',
      build: () {
        // arrange
        when(() => mockInputConvertor.stringToInt(any()))
            .thenReturn(const Left(InvalidInputFailure('')));
        return numberTriviaBloc;
      },
      act: (_) =>
          numberTriviaBloc.add(const GetTriviaForConcreteNumber(tNumberString)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        NumberTriviaLoadingSate(),
        const NumberTriviaErrorState(
            errorMessage: ViewText.inputFailureMessage),
      ],
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [NumberTriviaLoadingSate, NumberTriviaLoadedState] when data is gotten successfully',
      build: () {
        // arrange
        when(() => mockInputConvertor.stringToInt(any()))
            .thenReturn(const Right(tNumber));
        when(() => mockGetConcreteNumberTrivia.execute(any()))
            .thenAnswer((_) async => const Right(tNumberTrivia));
        return numberTriviaBloc;
      },
      act: (_) =>
          numberTriviaBloc.add(const GetTriviaForConcreteNumber(tNumberString)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        NumberTriviaLoadingSate(),
        const NumberTriviaLoadedState(numberTrivia: tNumberTrivia),
      ],
      verify: (_) {
        verify(() => mockGetConcreteNumberTrivia.execute(tNumber));
      },
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [NumberTriviaLoadingSate, NumberTriviaErrorState] when getting data from server fails',
      build: () {
        // arrange
        when(() => mockInputConvertor.stringToInt(any()))
            .thenReturn(const Right(tNumber));
        when(() => mockGetConcreteNumberTrivia.execute(any()))
            .thenAnswer((_) async => const Left(ServerFailure('')));
        return numberTriviaBloc;
      },
      act: (_) =>
          numberTriviaBloc.add(const GetTriviaForConcreteNumber(tNumberString)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        NumberTriviaLoadingSate(),
        const NumberTriviaErrorState(
            errorMessage: ViewText.serverFailureMessage),
      ],
      verify: (_) {
        verify(() => mockGetConcreteNumberTrivia.execute(tNumber));
      },
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [NumberTriviaLoadingSate, NumberTriviaErrorState] when getting data from cache fails',
      build: () {
        // arrange
        when(() => mockInputConvertor.stringToInt(any()))
            .thenReturn(const Right(tNumber));
        when(() => mockGetConcreteNumberTrivia.execute(any()))
            .thenAnswer((_) async => const Left(CacheFailure('')));
        return numberTriviaBloc;
      },
      act: (_) =>
          numberTriviaBloc.add(const GetTriviaForConcreteNumber(tNumberString)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        NumberTriviaLoadingSate(),
        const NumberTriviaErrorState(
            errorMessage: ViewText.cacheFailureMessage),
      ],
      verify: (_) {
        verify(() => mockGetConcreteNumberTrivia.execute(tNumber));
      },
    );
  });

  group('get random number trivia', () {
    const tNumberTrivia = NumberTrivia(text: 'test', number: 1);

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [NumberTriviaLoadingSate, NumberTriviaLoadedState] when data is gotten successfully',
      build: () {
        // arrange
        when(() => mockGetRandomNumberTrivia.execute())
            .thenAnswer((_) async => const Right(tNumberTrivia));
        return numberTriviaBloc;
      },
      act: (_) => numberTriviaBloc.add(const GetTriviaForRandomNumber()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        NumberTriviaLoadingSate(),
        const NumberTriviaLoadedState(numberTrivia: tNumberTrivia),
      ],
      verify: (_) {
        verify(() => mockGetRandomNumberTrivia.execute());
      },
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [NumberTriviaLoadingSate, NumberTriviaErrorState] when getting data from server fails',
      build: () {
        // arrange
        when(() => mockGetRandomNumberTrivia.execute())
            .thenAnswer((_) async => const Left(ServerFailure('')));
        return numberTriviaBloc;
      },
      act: (_) => numberTriviaBloc.add(const GetTriviaForRandomNumber()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        NumberTriviaLoadingSate(),
        const NumberTriviaErrorState(
            errorMessage: ViewText.serverFailureMessage),
      ],
      verify: (_) {
        verify(() => mockGetRandomNumberTrivia.execute());
      },
    );

    blocTest<NumberTriviaBloc, NumberTriviaState>(
      'should emit [NumberTriviaLoadingSate, NumberTriviaErrorState] when getting data from cache fails',
      build: () {
        // arrange
        when(() => mockGetRandomNumberTrivia.execute())
            .thenAnswer((_) async => const Left(CacheFailure('')));
        return numberTriviaBloc;
      },
      act: (_) => numberTriviaBloc.add(const GetTriviaForRandomNumber()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        NumberTriviaLoadingSate(),
        const NumberTriviaErrorState(
            errorMessage: ViewText.cacheFailureMessage),
      ],
      verify: (_) {
        verify(() => mockGetRandomNumberTrivia.execute());
      },
    );
  });
}
