import 'package:flutter/material.dart';

class ClearButton extends StatelessWidget {
  const ClearButton({
    Key? key,
    required this.onPress,
  }) : super(key: key);

  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        padding: const EdgeInsets.all(20.0),
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
      ),
      icon: const Icon(Icons.clear),
      label: const Text("Clear"),
    );
  }
}
