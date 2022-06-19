import 'dart:io';

import 'package:http/io_client.dart';
import 'package:lytt/podcast/episode.dart';
import 'package:lytt/podcast/podcast.dart';
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
  Future<File> writePodcastInfo(String text) async {
    final file = await _localFilePodcastLibrary;

    // Write the file
    return file.writeAsString(text);
  }
  /// Read from PodcastLibrary storage
  Future<String> readPodcastInfo() async {
    try {
      final file = await _localFilePodcastLibrary;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return -
      return "-";
    }
  }


  Future<String> _localDirectoryPodcast(String podcastTitle) async {
    final path = await _localPath;
    final directory = Directory("$path\\podcast\\$podcastTitle");

    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    return directory.path;
  }

  Future<File> _localFileEpisode(Episode episode) async {
    final path = await _localDirectoryPodcast(episode.podcastTitle);
    return File('$path/${episode.title.hashCode.toRadixString(32)}'
        '${episode.url.hashCode.toRadixString(32)}.mp3');
  }

  void downloadEpisode(Episode episode) async {
    final file = await _localFileEpisode(episode);
    file.writeAsBytes(await WebHandler().getAsBytes(episode.url));
  }

  Future<bool> isEpisodeDownloaded(Episode episode) async {
    return await(await _localFileEpisode(episode)).exists();
  }

  Future<Uri> episodeUri(Episode episode) async {
    var pos = await _localFileEpisode(episode);
    if (await(pos).exists()) {
        return pos.uri;
    }
    return Uri.parse(episode.url);
  }

  Future<File> localFileImage(String podcastTitle) async {
    final path = await _localDirectoryPodcast(podcastTitle);
    return File('$path\\image.png');
  }

  void downloadImage(Podcast podcast) async {
    final file = await localFileImage(podcast.title);
    file.writeAsBytes(await WebHandler().getAsBytes(podcast.image));
  }
}

class WebHandler {
  final client = IOClient();

  Future<List<int>> getAsBytes(url) async {
    return (await client.get(Uri.parse(url))).bodyBytes;
  }

  Future<String> getAsString(url) async {
    return (await client.get(Uri.parse(url))).body;
  }
}