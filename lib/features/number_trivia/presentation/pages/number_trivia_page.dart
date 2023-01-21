import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_app/core/constants/view_text.dart';
import 'package:number_trivia_app/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia_app/features/number_trivia/presentation/widgets/number_trivia_widgets.dart';
import 'package:number_trivia_app/injection.dart' as di;

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _body,
    );
  }

  PreferredSizeWidget get _appBar => AppBar(
        title: const Text(ViewText.numberTrivia),
      );

  Widget get _body => Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (_) => di.locator<NumberTriviaBloc>(),
          child: _bodyContent,
        ),
      );

  Widget get _bodyContent => Column(
        children: [
          Expanded(child: _triviaBody),
          const SizedBox(height: 16),
          NumberTriviaForm(),
        ],
      );

  Widget get _triviaBody {
    return Center(
      child: SingleChildScrollView(
        child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
          builder: (context, state) {
            if (state is NumberTriviaInitialState) {
              return const MessageText(ViewText.startSearching);
            } else if (state is NumberTriviaLoadingSate) {
              return const CircularProgressIndicator();
            } else if (state is NumberTriviaLoadedState) {
              return Trivia(numberTrivia: state.numberTrivia);
            }
            if (state is NumberTriviaErrorState) {
              return MessageText(state.errorMessage);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
