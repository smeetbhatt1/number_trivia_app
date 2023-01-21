import 'package:flutter/material.dart';
import 'package:number_trivia_app/features/number_trivia/domain/entities/number_trivia.dart';

class Trivia extends StatelessWidget {
  final NumberTrivia numberTrivia;

  const Trivia({
    required this.numberTrivia,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _numberText,
        const SizedBox(height: 24),
        _triviaText,
      ],
    );
  }

  Widget get _numberText => Text(
        numberTrivia.number.toString(),
        style: const TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget get _triviaText => Text(
        numberTrivia.text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 24,
        ),
      );
}
