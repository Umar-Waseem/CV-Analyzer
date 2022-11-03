import 'dart:io';

import 'package:file_picker/file_picker.dart';

class DropDown {
  File file;
  bool isOpen;

  DropDown({required this.file, required this.isOpen});
}

class FileHandler {
  FilePickerResult? result;
  static List<DropDown> files = [];

  static void toggleOpen(int index) {
    files[index].isOpen = !files[index].isOpen;
  }

  static void pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      files = result.paths.map(
        (path) {
          return DropDown(file: File(path!), isOpen: false);
        },
      ).toList();
      for (var file in files) {
        print(file.file.readAsStringSync());
      }
    } else {
      // User cancelled the picker
    }
  }
}
