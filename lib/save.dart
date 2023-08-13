import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'quote.dart';

class Save {



  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

  Future<void> writeFile(List<Quote> quotes) async {
    final file = await _localFile;

    // Write the file
    print('writing');
    await file.writeAsString(jsonEncode(quotes[0]));


  }

  Future<String> readFile() async {
    try {
      final file = await _localFile;
      final content = await file.readAsString();
      return content;
    } catch (e){
      return e.toString();
    }
  }

}