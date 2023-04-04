import 'package:flutter/material.dart';

class TextValue extends StatelessWidget {
  const TextValue({
    required this.currentTime,
  });

  final String currentTime;

  @override
  Widget build(BuildContext context) {
    return Text(currentTime);
  }
}
