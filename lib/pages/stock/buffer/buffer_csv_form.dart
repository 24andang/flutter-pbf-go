import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void uploadCSVDialog(
  BuildContext parentContext,
  File filepath,
  String filelabel,
  Widget uploadBtn,
) {
  showDialog(
    context: parentContext,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: Text('Form Upload Mutasi'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['csv'],
                    );
                    if (result != null) {
                      setStateDialog(() {
                        filepath = File(result.files.single.path!);

                        filelabel = result.files.single.name;
                      });
                    }
                  },
                  icon: Icon(Icons.file_upload_outlined),
                  label: Text(filelabel),
                ),
                uploadBtn,
              ],
            ),
          );
        },
      );
    },
  );
}
