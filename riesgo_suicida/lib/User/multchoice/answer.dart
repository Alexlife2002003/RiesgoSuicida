import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback selectHandler;
  final String answerText;

  const Answer(this.selectHandler, this.answerText, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color btnColor = const Color.fromARGB(255, 74, 101, 211);
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(btnColor)),
      onPressed: selectHandler,
      child: SizedBox(
        width: 240,
        child: Text(
          answerText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
