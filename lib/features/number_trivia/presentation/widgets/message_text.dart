import 'package:flutter/material.dart';

class MessageText extends StatelessWidget {
  final String message;
  const MessageText(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 24,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}
