import 'package:flutter/material.dart';

class TextControl extends StatelessWidget {
  final Function()? resetHandler;
  TextControl(this.resetHandler);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: resetHandler,
        child: const Text("Get a new time"),
      ),
    );
  }
}
