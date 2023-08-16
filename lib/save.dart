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

    /*if(quotes.isEmpty){
      file.writeAsStringSync('');
    }*/

    // Write the file
    String _objtext = '';
    for (var i = 0; i<quotes.length; i++){
      _objtext += '${jsonEncode(quotes[i])}\n';
    }

    if(!_objtext.isEmpty) _objtext = _objtext.substring(0,_objtext.length-1);

    await file.writeAsString(_objtext);
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