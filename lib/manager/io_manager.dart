import 'dart:convert';
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
  Future<String?> readPodcastInfo() async {
    try {
      final file = await _localFilePodcastLibrary;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return -
      return null;
    }
  }

  Future<String> _localDirectoryPodcast(String podcastId) async {
    final path = await _localPath;
    final directory = Directory("$path\\podcast\\$podcastId");

    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    return directory.path;
  }

  Future<File> _localFileEpisode(Episode episode) async {
    final path = await _localDirectoryPodcast(episode.podcastId);
    return File('$path/${episode.filename}');
  }

  Future<void> downloadEpisode(Episode episode) async {
    final file = await _localFileEpisode(episode);
    file.writeAsBytes(await WebHandler().getAsBytes(episode.url));
  }

  Future<void> removeEpisode(Episode episode) async {
    final file = await _localFileEpisode(episode);
    file.delete();
  }

  Future<bool> isEpisodeDownloaded(Episode episode) async {
    return await (await _localFileEpisode(episode)).exists();
  }

  Future<Uri?> episodeUri(Future<Episode?> episode) async {
    final e = await episode;
    if (e == null) {
      return null;
    }
    var pos = await _localFileEpisode(e);
    if (await (pos).exists()) {
      return pos.uri;
    }
    return Uri.parse(e.url);
  }

  Future<Directory> _localFileImage(String podcastId) async {
    final path = await _localDirectoryPodcast(podcastId);
    final directory = Directory('$path\\image');
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    return directory;
  }

  Future<File?> localFileImage(String podcastId) async {
    final directory = await _localFileImage(podcastId);
    if (directory.listSync().isEmpty) {
      return null;
    }
    return File(directory.listSync().first.path);
  }

  void downloadImage(Podcast podcast) async {
    final directory = await _localFileImage(podcast.id);
    if (directory.listSync().isNotEmpty) {
      File(directory.listSync().first.path).delete();
    }
    final file = File('${directory.path}\\image.${urlFileName(podcast.image)}');
    file.writeAsBytes(await WebHandler().getAsBytes(podcast.image));
  }

  static String urlFileName(String url) {
    return url.split('?').first.split('.').last;
  }
}

class WebHandler {
  final client = IOClient();


  Future<List<int>> getAsBytes(url) async {
    return (await client.get(Uri.parse(url))).bodyBytes;
  }

  Future<String> getAsString(url) async {
    final bytes = (await client.get(Uri.parse(url))).bodyBytes;
    return utf8.decode(bytes);
  }
}
