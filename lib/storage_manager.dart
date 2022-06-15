
import 'dart:io';

import 'package:http/io_client.dart';
import 'package:path_provider/path_provider.dart';

class StorageHandler {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFilePodcastLibrary async {
    final path = await _localPath;
    return File('$path/lytt/last.txt');
  }

  Future<File> writeString(String text) async {
    final file = await _localFilePodcastLibrary;

    // Write the file
    return file.writeAsString(text);
  }

  Future<String> readString() async {
    try {
      final file = await _localFilePodcastLibrary;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return "-";
    }
  }


  Future<File> _localFileDownloads(String name) async {
    final path = await _localPath;
    return File('$path/lytt/downloads/$name.mp3');
  }

  void downloadFile(String url) async {
    final file = await _localFileDownloads(url.hashCode.toRadixString(36));

    final client = IOClient();
    var response = await client.get(Uri.parse(url));
    
    file.writeAsBytes(response.bodyBytes);
  }

}