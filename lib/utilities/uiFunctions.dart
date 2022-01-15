import 'package:flutter/material.dart';
import 'package:nssapp/utilities/styling.dart';

showConfirmDialog(BuildContext context,
    {required String title,
    required String content,
    required void Function() onConfirm}) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel", style: TextStyle(fontFamily: "Roboto")),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Do it", style: TextStyle(fontFamily: "Roboto")),
    onPressed: () {
      onConfirm();
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      title,
      style: TextStyle(fontSize: 22),
    ),
    content: Text(content,
        style: TextStyle(
            fontFamily: "Roboto",
            color: AppTheme.textBlackColor,
            fontSize: 16)),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void showInputDialog(BuildContext context,
    {required String title,
    required String message,
    String hintText = "Input",
    required void Function(String) onInput}) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel", style: TextStyle(fontFamily: "Roboto")),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  final textController = TextEditingController();
  Widget continueButton = TextButton(
    child: Text("Do it", style: TextStyle(fontFamily: "Roboto")),
    onPressed: () {
      onInput(textController.text);
      Navigator.pop(context);
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text(
      title,
      style: TextStyle(fontSize: 22),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(message),
        SizedBox(height: 10),
        TextField(
          controller: textController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: hintText,
          ),
        )
      ],
    ),
    actions: [cancelButton, continueButton],
  );
  showDialog(context: context, builder: (context) => alert);
}
