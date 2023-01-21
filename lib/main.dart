import 'package:flutter/material.dart';
import 'package:number_trivia_app/core/constants/view_text.dart';
import 'package:number_trivia_app/features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'package:number_trivia_app/injection.dart' as di;
import 'package:number_trivia_app/theme/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ViewText.numberTrivia,
      theme: AppThemes().primary,
      home: const NumberTriviaPage(),
    );
  }
}
