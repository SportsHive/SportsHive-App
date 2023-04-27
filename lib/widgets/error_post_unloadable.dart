import 'package:flutter/material.dart';

class ErrorPostUnloadable extends StatelessWidget {
  const ErrorPostUnloadable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const Center(
        child: Text(
          "This post couldn't be loaded.",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
