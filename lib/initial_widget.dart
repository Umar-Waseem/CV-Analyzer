import 'package:flutter/material.dart';

import 'widgets/search_button.dart';
import 'widgets/search_field.dart';
import 'widgets/upload_button.dart';

class InitialWidget extends StatefulWidget {
  const InitialWidget({super.key});

  @override
  State<InitialWidget> createState() => _InitialWidgetState();
}

class _InitialWidgetState extends State<InitialWidget> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SearchField(searchController: searchController),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SearchButton(searchValue: searchController.text),
                  const SizedBox(width: 30),
                  const UploadButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
