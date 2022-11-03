import 'package:cv_analyzer/providers/search_handler.dart';
import 'package:flutter/material.dart';

import '../providers/file_handler.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    Key? key,
    required this.searchValue,
  }) : super(key: key);

  final String searchValue;

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
      onPressed: () {
        List<int> values = SearchHandler.bruteForceSearch(
          FileHandler.files[0].file.readAsStringSync(),
          searchValue,
        );

        for (var element in values) {
          print(element);
        }
      },
      label: const Text("Search"),
    );
  }
}
