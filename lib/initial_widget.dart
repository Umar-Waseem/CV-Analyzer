import 'package:cv_analyzer/providers/file_handler.dart';
import 'package:flutter/material.dart';

import 'providers/search_handler.dart';
import 'widgets/search_button.dart';
import 'widgets/search_field.dart';
import 'widgets/seperator.dart';
import 'widgets/upload_button.dart';

class InitialWidget extends StatefulWidget {
  const InitialWidget({super.key});

  @override
  State<InitialWidget> createState() => _InitialWidgetState();
}

class _InitialWidgetState extends State<InitialWidget> {
  final TextEditingController searchController = TextEditingController();
  List<int> values = [];
  List<TextSpan> subTextSpans = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SearchField(searchController: searchController),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SearchButton(
                      onPress: () {
                        setState(() {
                          subTextSpans = SearchHandler.searchedWordsView(
                              searchController.text);
                        });
                      },
                    ),
                    const SizedBox(width: 30),
                    UploadButton(
                      onPressed: () {
                        setState(() {
                          FileHandler.pickFile();
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Seperator();
                  },
                  shrinkWrap: true,
                  itemCount: FileHandler.files.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                FileHandler.files[index].file.path,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    FileHandler.toggleOpen(index);
                                  });
                                },
                                icon: FileHandler.files[index].isOpen
                                    ? const Icon(Icons.keyboard_arrow_up)
                                    : const Icon(Icons.keyboard_arrow_down),
                              ),
                            ],
                          ),
                          if (FileHandler.files[index].isOpen)
                            // FileHandler.files[index].file.readAsStringSync(),
                            subTextSpans.isEmpty
                                ? Text(
                                    FileHandler.files[index].file
                                        .readAsStringSync(),
                                  )
                                : RichText(
                                    text: TextSpan(
                                      style:
                                          const TextStyle(color: Colors.white),
                                      children: subTextSpans,
                                    ),
                                  ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
