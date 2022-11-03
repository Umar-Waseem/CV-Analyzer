import 'package:flutter/material.dart';

import '../providers/file_handler.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.upload),
      style: ElevatedButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        padding: const EdgeInsets.all(20.0),
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      ),
      label: const Text("Upload"),
      onPressed: () async {
        FileHandler.pickFile();
        FileHandler.uploadFile();
        FileHandler.displayFileNames();
        FileHandler.readFileData();
      },
    );
  }
}
