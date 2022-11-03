import 'package:flutter/material.dart';

import '../providers/file_handler.dart';

class UploadButton extends StatefulWidget {
  const UploadButton({
    Key? key,
  }) : super(key: key);

  @override
  State<UploadButton> createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
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
        setState(() {
          FileHandler.pickFile();
        });
      },
    );
  }
}
