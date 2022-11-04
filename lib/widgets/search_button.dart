import 'package:flutter/material.dart';

class SearchButton extends StatefulWidget {
  const SearchButton({
    Key? key,
    required this.onPress,
  }) : super(key: key);

  final Function() onPress;

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.search),
      style: ElevatedButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        padding: const EdgeInsets.all(20.0),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      onPressed: widget.onPress,
      label: const Text("Search"),
    );
  }
}
