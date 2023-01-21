import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_app/core/constants/view_text.dart';
import 'package:number_trivia_app/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class NumberTriviaForm extends StatelessWidget {
  final _numberController = TextEditingController();

  NumberTriviaForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _numberTextField(context),
        const SizedBox(height: 16),
        _buttons(context),
      ],
    );
  }

  Widget _numberTextField(BuildContext context) => TextFormField(
        controller: _numberController,
        keyboardType: TextInputType.number,
        decoration: _inputDecoration,
        inputFormatters: _textInputFormatter,
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (_) => _onSearchClick(context),
      );

  Widget _buttons(BuildContext context) => Row(
        children: [
          Expanded(child: _searchButton(context)),
          const SizedBox(width: 8),
          Expanded(child: _randomSearchButton(context)),
        ],
      );

  Widget _searchButton(BuildContext context) => ElevatedButton(
        onPressed: () => _onSearchClick(context),
        child: const Text(ViewText.search),
      );

  void _onSearchClick(BuildContext context) {
    context
        .read<NumberTriviaBloc>()
        .add(GetTriviaForConcreteNumber(_numberController.text));
    clearNumberControllerText();
  }

  Widget _randomSearchButton(BuildContext context) => ElevatedButton(
        onPressed: () => _onRandomClick(context),
        child: const Text(ViewText.randomNumber),
      );

  void _onRandomClick(BuildContext context) {
    context.read<NumberTriviaBloc>().add(const GetTriviaForRandomNumber());
    clearNumberControllerText();
  }

  void clearNumberControllerText() => _numberController.clear();

  InputDecoration get _inputDecoration => const InputDecoration(
        border: OutlineInputBorder(),
        hintText: ViewText.enterANumber,
      );

  List<TextInputFormatter> get _textInputFormatter => <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ];
}
