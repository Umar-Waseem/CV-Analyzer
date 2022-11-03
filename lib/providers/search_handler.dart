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
    final List<int> result = <int>[];
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

}
