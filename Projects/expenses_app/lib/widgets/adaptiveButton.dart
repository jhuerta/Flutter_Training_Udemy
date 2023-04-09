import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptiveButton extends StatelessWidget {
  final Function() _presentDatePicker;
  final String text;

  AdaptiveButton(this._presentDatePicker, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    var pickDateIosButton = CupertinoButton(
      onPressed: _presentDatePicker,
      child: FittedBox(
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
    );

    var pickDateAndroidButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(10),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      onPressed: _presentDatePicker,
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10),
      ),
    );

    return Platform.isIOS ? pickDateIosButton : pickDateAndroidButton;
  }
}
