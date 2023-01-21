part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

class NumberTriviaInitialState extends NumberTriviaState {}

class NumberTriviaLoadingSate extends NumberTriviaState {}

class NumberTriviaLoadedState extends NumberTriviaState {
  final NumberTrivia numberTrivia;

  const NumberTriviaLoadedState({required this.numberTrivia});

  @override
  List<Object> get props => [numberTrivia];
}

class NumberTriviaErrorState extends NumberTriviaState {
  final String errorMessage;

  const NumberTriviaErrorState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
