import 'package:flutter/material.dart';

showDialogWidget({BuildContext? context, String? title ,String? body}) {
  return showDialog(
    context: context!,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
          title: Text(
            title!,
            style: TextStyle(color: Colors.red),
          ),
          content: Container(
            height: 200,
            width: 300,
            child: Center(
              child: Text(body!),
            ),
          ));
    },
  );
}
