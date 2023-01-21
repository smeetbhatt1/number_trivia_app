import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia_app/core/constants/view_text.dart';
import 'package:number_trivia_app/core/error/failures.dart';
import 'package:number_trivia_app/core/utils/input_convertor.dart';
import 'package:number_trivia_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia_app/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConvertor inputConvertor;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConvertor,
  }) : super(NumberTriviaInitialState()) {
    on<GetTriviaForConcreteNumber>(_onGetTriviaForConcreteNumber);
    on<GetTriviaForRandomNumber>(_onGetTriviaForRandomNumber);
  }

  Future<void> _onGetTriviaForConcreteNumber(
      GetTriviaForConcreteNumber event, Emitter<NumberTriviaState> emit) async {
    final inputEither = inputConvertor.stringToInt(event.numberString);

    emit(NumberTriviaLoadingSate());

    await inputEither.fold((l) {
      emit(const NumberTriviaErrorState(
          errorMessage: ViewText.inputFailureMessage));
    }, (r) async {
      final failureOrTrivia = await getConcreteNumberTrivia.execute(r);
      await _handleEitherFailureOrTrivia(failureOrTrivia, emit);
    });
  }

  Future<void> _onGetTriviaForRandomNumber(
      GetTriviaForRandomNumber event, Emitter<NumberTriviaState> emit) async {
    emit(NumberTriviaLoadingSate());

    final failureOrTrivia = await getRandomNumberTrivia.execute();
    await _handleEitherFailureOrTrivia(failureOrTrivia, emit);
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return ViewText.serverFailureMessage;
      case CacheFailure:
        return ViewText.cacheFailureMessage;
      default:
        return 'Unexpected Error occurred';
    }
  }

  Future<void> _handleEitherFailureOrTrivia(
    Either<Failure, NumberTrivia> failureOrTrivia,
    Emitter<NumberTriviaState> emit,
  ) async {
    failureOrTrivia.fold((failure) {
      emit(
        NumberTriviaErrorState(errorMessage: _mapFailureToMessage(failure)),
      );
    }, (trivia) {
      emit(NumberTriviaLoadedState(numberTrivia: trivia));
    });
  }
}
