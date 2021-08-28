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
