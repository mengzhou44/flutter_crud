import 'package:flutter/material.dart';
import '../utils/constants.dart';

class Button extends StatelessWidget {
  final String buttonText;
  final void Function() onPressed;

  Button({Key key, this.buttonText, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.buttonRadius)),
      padding: const EdgeInsets.all(8.0),
      textColor: Colors.black,
      color: Colors.teal[100],
      onPressed: onPressed,
      child: new Text(buttonText),
    );
  }
}
