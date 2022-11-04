import 'package:flutter/material.dart';

class UploadButton extends StatefulWidget {
  const UploadButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  // on press

  final Function() onPressed;

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
      onPressed: widget.onPressed,
    );
  }
}
