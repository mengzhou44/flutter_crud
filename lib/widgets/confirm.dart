import 'package:flutter/material.dart';

class Confirm extends StatelessWidget {
  final String confirmText;
  
  Confirm({Key key, this.confirmText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
              title: const Text("Confirm"),
              content:  Text(confirmText),
              actions: <Widget>[
                  FlatButton(onPressed: () => Navigator.of(context).pop(true),
                                            child: const Text("DELETE")
                                        ),

                      FlatButton(
                                          onPressed: () => Navigator.of(context).pop(false),
                                          child: const Text("CANCEL"),)
                       ],
              );
  }
}