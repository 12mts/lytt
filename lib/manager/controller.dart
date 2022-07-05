import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lytt/player/player.dart';
import 'package:lytt/podcast/episode.dart';
import 'package:lytt/manager/library_manager.dart';
import 'package:lytt/podcast/podcast.dart';
import 'package:webfeed/domain/rss_feed.dart';

import 'io_manager.dart';

class Controller {
  final _storage = StorageHandler();
  PodcastManager _library = PodcastManager();
  final _web = WebHandler();
  late final PlayerController player;

  Controller() {
    _storage.readPodcastInfo().then((string) => {
          if (string != null)
            {_library = PodcastManager.fromJson(jsonDecode(string))}
        });
    player = PlayerController(this);
  }

  Stream<List<Podcast>> getPodcasts() {
    return _library.getPodcastStream();
  }

  void playEpisode(Episode episode) {
    player.playEpisode(episode);
  }

  Future<Podcast> podcastURL(String url) async {
    return Podcast.fromFeed(url, RssFeed.parse(await _web.getAsString(url)));
  }

  Future<Podcast> addPodcast(String url) async {
    final podcast = await podcastURL(url);
    _library.addPodcast(podcast);
    _storage.downloadImage(podcast);
    _storage.writePodcastInfo(jsonEncode(_library.lib));
    return podcast;
  }

  Future<Image?> imageFile(String podcastTitle) async {
    final file = await _storage.localFileImage(podcastTitle);
    if (file != null) {
      return Image.file(file);
    }
    return null;
  }

  Future<Image> imageFilePodcast(Podcast podcast) async {
    final image = await imageFile(podcast.id);
    if (image != null) {
      return image;
    }
    return Image.network(podcast.image);
  }

  Future<bool> updatePodcast(Podcast podcast) async {
    return podcast.updatePodcast(
        RssFeed.parse(await _web.getAsString(podcast.rssUrl)));
  }
}

class PlayerController {
  final _storage = StorageHandler();
  Episode episode = Episode(
      "http://traffic.libsyn.com/hellointernet/HI20320--20Four20Light20Bulbs.mp3",
      "H.I. #3: Four Light Bulbs, ÆØÅ",
      "r77mft");
  late final Player _player;

  PlayerController(Controller controller) {
    _player = Player(episode.url);
  }

  void playEpisode(Episode episode) {
    this.episode = episode;
    _player.setEpisode(_storage.episodeUri(episode));
  }

  bool startStop() {
    return _player.startStop();
  }

  Stream<PlayerDurationState> playerState() {
    return _player.playerState();
  }

  void setTime(Duration duration) {
    _player.setTime(duration);
  }
}