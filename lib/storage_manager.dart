
import 'dart:io';

import 'package:http/io_client.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lytt/podcast.dart';
import 'package:path_provider/path_provider.dart';

class StorageHandler {
  /// Source folder
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return '${directory.path}\\lytt';
  }

  /// File for PodcastLibrary
  Future<File> get _localFilePodcastLibrary async {
    final path = await _localPath;
    return File('$path\\podcast_info.txt');
  }

  /// Write to PodcastLibrary storage
  Future<File> writeString(String text) async {
    final file = await _localFilePodcastLibrary;

    // Write the file
    return file.writeAsString(text);
  }
  /// Read from PodcastLibrary storage
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


  Future<String> _localDirectoryPodcast(Podcast podcast) async {
    final path = await _localPath;
    final directory = Directory("$path\\podcast\\${podcast.title}");

    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    return directory.path;
  }

  Future<File> _localFileDownloads(Podcast podcast, Episode episode) async {
    final path = await _localDirectoryPodcast(podcast);
    return File('$path/${episode.url.hashCode.toRadixString(32)}.mp3');
  }

  void downloadFile(Podcast podcast, Episode episode) async {
    final file = await _localFileDownloads(podcast, episode);

    final client = IOClient();
    var response = await client.get(Uri.parse(episode.url));
    
    file.writeAsBytes(response.bodyBytes);
  }

  Future<AudioSource> episodeSource(Podcast podcast, Episode episode) async {
    Uri uri;
    var pos = await _localFileDownloads(podcast, episode);
    if (await(pos).exists()) {
        uri = pos.uri;
    } else {
        uri = Uri.parse(episode.url);
    }

    return AudioSource.uri(uri);
  }

}