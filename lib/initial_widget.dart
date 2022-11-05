import 'package:cv_analyzer/providers/file_handler.dart';
import 'package:flutter/material.dart';

import 'providers/search_handler.dart';
import 'widgets/clear_button.dart';
import 'widgets/search_button.dart';
import 'widgets/search_field.dart';
import 'widgets/seperator.dart';
import 'widgets/upload_button.dart';

enum SearchFilter { matchCase, matchWholeWord, matchBoth, none }

enum FunctionFilter { bruteForce, kmp, rk }

class InitialWidget extends StatefulWidget {
  const InitialWidget({super.key});

  @override
  State<InitialWidget> createState() => _InitialWidgetState();
}

class _InitialWidgetState extends State<InitialWidget> {
  final TextEditingController searchController = TextEditingController();
  List<int> values = [];
  List<List<TextSpan>> subTextSpans = [];

  bool matchCase = false;
  bool matchWholeWord = false;
  bool isEnabled = false;

  bool isBruteForce = true;
  bool isKMP = false;
  bool isRK = false;

  @override
  void initState() {
    searchController.addListener(() {
      setState(() {
        isEnabled = searchController.text.isNotEmpty;
      });
    });
    super.initState();
  }

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
                      onPress: isEnabled && FileHandler.files.isNotEmpty
                          ? () {
                              setState(() {
                                FunctionFilter function =
                                    FunctionFilter.bruteForce;
                                if (isKMP) {
                                  function = FunctionFilter.kmp;
                                } else if (isRK) {
                                  function = FunctionFilter.rk;
                                }

                                subTextSpans = [];
                                if (matchCase && matchWholeWord) {
                                  subTextSpans =
                                      SearchHandler.searchedWordsView(
                                    searchController.text,
                                    SearchFilter.matchBoth,
                                    function,
                                  );
                                } else if (matchCase) {
                                  subTextSpans =
                                      SearchHandler.searchedWordsView(
                                    searchController.text,
                                    SearchFilter.matchCase,
                                    function,
                                  );
                                } else if (matchWholeWord) {
                                  subTextSpans =
                                      SearchHandler.searchedWordsView(
                                    searchController.text,
                                    SearchFilter.matchWholeWord,
                                    function,
                                  );
                                } else {
                                  subTextSpans =
                                      SearchHandler.searchedWordsView(
                                    searchController.text,
                                    SearchFilter.none,
                                    function,
                                  );
                                }
                              });
                            }
                          : null,
                    ),
                    const SizedBox(width: 30),
                    UploadButton(
                      onPressed: () {
                        setState(() {
                          FileHandler.pickFile();
                        });
                      },
                    ),
                    const SizedBox(width: 30),
                    ClearButton(
                      onPress: () {
                        setState(() {
                          subTextSpans = [];
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Match Case"),
                    Checkbox(
                        value: matchCase,
                        onChanged: (value) {
                          setState(() {
                            matchCase = value!;
                          });
                        }),
                    const SizedBox(width: 10),
                    const Text("Match Whole Word"),
                    Checkbox(
                        value: matchWholeWord,
                        onChanged: (value) {
                          setState(() {
                            matchWholeWord = value!;
                          });
                        }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const Text("Brute Force Seacrh"),
                        Checkbox(
                            value: isBruteForce,
                            onChanged: (value) {
                              setState(() {
                                if (!value!) {
                                  return;
                                }
                                isBruteForce = value;
                                isKMP = false;
                                isRK = false;
                              });
                            }),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("KMP Search"),
                        Checkbox(
                            value: isKMP,
                            onChanged: (value) {
                              setState(() {
                                if (!value!) {
                                  return;
                                }
                                isKMP = value;
                                isBruteForce = false;
                                isRK = false;
                              });
                            }),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Rabin Karp Search"),
                        Checkbox(
                            value: isRK,
                            onChanged: (value) {
                              setState(() {
                                if (!value!) {
                                  return;
                                }
                                isRK = value;
                                isBruteForce = false;
                                isKMP = false;
                              });
                            }),
                      ],
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
                                      children: subTextSpans[index],
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
