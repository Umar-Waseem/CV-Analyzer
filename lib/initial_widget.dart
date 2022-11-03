import 'package:flutter/material.dart';

import 'widgets/search_field.dart';

class InitialWidget extends StatelessWidget {
  const InitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SearchField(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.all(20.0),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black54,
                ),
                onPressed: () {},
                child: const Text("Search"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
