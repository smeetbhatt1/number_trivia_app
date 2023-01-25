import 'package:flutter/material.dart';
import 'package:number_trivia_app/core/constants/app_images.dart';
import 'package:number_trivia_app/core/constants/view_text.dart';
import 'package:number_trivia_app/features/number_trivia/presentation/widgets/app_info_tile.dart';
import 'package:number_trivia_app/theme/app_colors.dart';

class NumberTriviaBackLayer extends StatelessWidget {
  const NumberTriviaBackLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AppInfoTile(),
      ],
    );
  }
}
