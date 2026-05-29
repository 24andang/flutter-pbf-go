import 'package:dfa_pbf_fe/widgets/button.dart';
import 'package:flutter/material.dart';

class PbfAlert {
  static void confirm(
    BuildContext context, {
    required String title,
    String content = '',
    required String actionText,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            DeleteBtn(
              text: actionText,
              onclick: () {
                onConfirm();
                Navigator.pop(context);
              },
            ),
            PopBtn(text: "Batal"),
          ],
        );
      },
    );
  }

  static void info(
    BuildContext context, {
    required String title,
    required String actionText,
    required String content,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            MainBtn(
              text: actionText,
              onclick: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
