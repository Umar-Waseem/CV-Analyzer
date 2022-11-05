import 'dart:developer';

import 'package:flutter/material.dart';

import '../initial_widget.dart';
import 'file_handler.dart';

class SearchHandler {
  // rk string search algorithm returning List<int> of indexes

  static List<int> rkSearch(String text, String pattern) {
    final List<int> indexes = [];
    final int patternLength = pattern.length;
    final int textLength = text.length;
    const int prime = 101;
    int patternHash = 0;
    int textHash = 0;
    int h = 1;
    for (int i = 0; i < patternLength - 1; i++) {
      h = (h * 256) % prime;
    }
    for (int i = 0; i < patternLength; i++) {
      patternHash = (256 * patternHash + pattern.codeUnitAt(i)) % prime;
      textHash = (256 * textHash + text.codeUnitAt(i)) % prime;
    }
    for (int i = 0; i <= textLength - patternLength; i++) {
      if (patternHash == textHash) {
        bool flag = true;
        for (int j = 0; j < patternLength; j++) {
          if (text[i + j] != pattern[j]) {
            flag = false;
            break;
          }
        }
        if (flag) {
          indexes.add(i);
        }
      }
      if (i < textLength - patternLength) {
        textHash = (256 * (textHash - text.codeUnitAt(i) * h) +
                text.codeUnitAt(i + patternLength)) %
            prime;
        if (textHash < 0) {
          textHash = (textHash + prime);
        }
      }
    }
    log("rk algo running");
    return indexes;
  }

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
    log("kmp algo running");
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
    log("brute force algo running");
    return result;
  }

  static List<List<TextSpan>> searchedWordsView(
    String searchedPattern,
    SearchFilter filter,
    FunctionFilter functionFilter,
  ) {
    // 2d integer array with specific length
    List<List<int>> values = [];
    bool? matchWhole = false;

    Function(String, String) searchFunction;

    switch (functionFilter) {
      case FunctionFilter.rk:
        searchFunction = rkSearch;
        break;
      case FunctionFilter.kmp:
        searchFunction = kmpSearch;
        break;
      case FunctionFilter.bruteForce:
        searchFunction = bruteForceSearch;
        break;
      default:
        searchFunction = bruteForceSearch;
    }

    if (filter == SearchFilter.matchBoth) {
      for (int fileIndex1 = 0;
          fileIndex1 < FileHandler.files.length;
          fileIndex1++) {
        values.add(
          searchFunction(FileHandler.files[fileIndex1].file.readAsStringSync(),
              searchedPattern),
        );
      }
      matchWhole = true;
    } else if (filter == SearchFilter.matchCase) {
      for (int fileIndex2 = 0;
          fileIndex2 < FileHandler.files.length;
          fileIndex2++) {
        values.add(searchFunction(
            FileHandler.files[fileIndex2].file.readAsStringSync(),
            searchedPattern));
      }
    } else if (filter == SearchFilter.matchWholeWord) {
      for (int fileIndex3 = 0;
          fileIndex3 < FileHandler.files.length;
          fileIndex3++) {
        values.add(searchFunction(
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
        values.add(searchFunction(data, searchedPattern.toLowerCase()));
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
