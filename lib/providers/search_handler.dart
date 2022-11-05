import 'dart:developer';

import 'package:flutter/material.dart';

import '../initial_widget.dart';
import 'file_handler.dart';

class SearchHandler {
  // kmp string search algorithm

  static List<int> kmpTable(String pattern) {
    final List<int> table = List<int>.filled(pattern.length, 0);
    int i = 1;
    int j = 0;
    while (i < pattern.length) {
      if (pattern[i] == pattern[j]) {
        table[i] = j + 1;
        i++;
        j++;
      } else if (j > 0) {
        j = table[j - 1];
      } else {
        i++;
      }
    }
    return table;
  }

  static List<int> kmpSearch(String text, String pattern) {
    final List<int> table = kmpTable(pattern);
    final List<int> result = <int>[];
    int i = 0;
    int j = 0;
    while (i < text.length) {
      if (text[i] == pattern[j]) {
        if (j == pattern.length - 1) {
          result.add(i - pattern.length + 1);
          j = table[j];
        } else {
          i++;
          j++;
        }
      } else if (j > 0) {
        j = table[j - 1];
      } else {
        i++;
      }
    }
    return result;
  }

  // brute force string search algorithm

  static List<int> bruteForceSearch(String text, String pattern) {
    final List<int> result = [];
    for (int i = 0; i < text.length - pattern.length + 1; i++) {
      int j = 0;
      while (j < pattern.length && text[i + j] == pattern[j]) {
        j++;
      }
      if (j == pattern.length) {
        result.add(i);
      }
    }

    return result;
  }

  static List<List<TextSpan>> searchedWordsViewBruteForce(
    String searchedPattern,
    SearchFilter filter,
  ) {
    // 2d integer array with specific length
    List<List<int>> values = [];
    bool? matchWhole = false;

    if (filter == SearchFilter.matchBoth) {
      for (int fileIndex1 = 0;
          fileIndex1 < FileHandler.files.length;
          fileIndex1++) {
        values.add(
          bruteForceSearch(
              FileHandler.files[fileIndex1].file.readAsStringSync(),
              searchedPattern),
        );
      }

      matchWhole = true;
    } else if (filter == SearchFilter.matchCase) {
      for (int fileIndex2 = 0;
          fileIndex2 < FileHandler.files.length;
          fileIndex2++) {
        values.add(bruteForceSearch(
            FileHandler.files[fileIndex2].file.readAsStringSync(),
            searchedPattern));
      }
    } else if (filter == SearchFilter.matchWholeWord) {
      for (int fileIndex3 = 0;
          fileIndex3 < FileHandler.files.length;
          fileIndex3++) {
        values.add(bruteForceSearch(
            FileHandler.files[fileIndex3].file.readAsStringSync().toLowerCase(),
            searchedPattern.toLowerCase()));
      }
      matchWhole = true;
    } else {
      // loop over all files and fill the values list with the indices of the searched pattern
      for (int fileIndex4 = 0;
          fileIndex4 < FileHandler.files.length;
          ++fileIndex4) {
        String data =
            FileHandler.files[fileIndex4].file.readAsStringSync().toLowerCase();
        values.add(bruteForceSearch(data, searchedPattern.toLowerCase()));
      }
    }

    for (var element in values) {
      log(element.toString());
    }

    List<List<TextSpan>> subTextSpans = List.generate(
      FileHandler.files.length,
      (_) {
        return [];
      },
    );

    log("length of spans is: ${subTextSpans.length}");

    // looping over files
    for (int fileIndex = 0; fileIndex < FileHandler.files.length; ++fileIndex) {
      String fileData = FileHandler.files[fileIndex].file.readAsStringSync();
      // subTextSpans.add([]);
      // looping over data of single file
      for (var i = 0; i < fileData.length; i++) {
        if (values[fileIndex].contains(i)) {
          if (!matchWhole) {
            subTextSpans[fileIndex].add(
              // text span till the end of word
              TextSpan(
                text: fileData.substring(i, i + searchedPattern.length),
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            );
            i += searchedPattern.length - 1;
          } else {
            subTextSpans[fileIndex].add(
              // text span from current index until next space
              TextSpan(
                text: fileData.substring(i, i + fileData.indexOf(' ', i) - i),
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            );
          }
        } else {
          subTextSpans[fileIndex].add(
            TextSpan(
              // i to end of word
              text: fileData.substring(i, i + 1),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          );
        }
      }
    }

    return subTextSpans;
  }
}
