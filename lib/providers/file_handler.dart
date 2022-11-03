import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FileHandler {
  static FilePickerResult? result;

  static void pickFile() async {
    result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );
  }

  static void uploadFile() {
    if (result != null) {
      List<File> files = result!.paths.map((path) => File(path!)).toList();
      log(files.toString());
    } else {
      // User canceled the picker
    }
  }

  static void displayFileNames() {
    // save names of files picked in a list
    log("File names: ");
    try {
      List<String?> fileNames = result!.names;
      log(fileNames.toString());
    } catch (e) {
      log(e.toString(), name: "Error");
    }
  }

  static void readFileData() {
    // read text file data and save
    log("File data: ");
    try {
      List<String?> fileData =
          result!.files.map((e) => e.bytes.toString()).toList();
      log(fileData.toString());
    } catch (e) {
      log(e.toString(), name: "Error");
    }
  }
}
