import 'package:flutter/material.dart';
import 'package:lytt/DAO/playlist_dao.dart';
import 'package:lytt/player/player.dart';
import 'package:lytt/podcast/episode.dart';
import 'package:lytt/podcast/playlist.dart';
import 'package:lytt/podcast/podcast.dart';
import 'package:webfeed/domain/rss_feed.dart';

import '../DAO/database.dart';
import '../DAO/podcast_dao.dart';
import 'io_manager.dart';

class Controller {
  final _storage = StorageHandler();
  late final PodcastManager _podcast;
  late final PlaylistManager _playlist;
  final _web = WebHandler();
  late final PlayerController player;

  Controller() {
    $FloorPodcastDatabase.databaseBuilder('podcast.db').build().then((db) {
      _podcast = PodcastManager(db);
      _playlist = PlaylistManager(db);
    });
    player = PlayerController(this);
  }

  Stream<List<Podcast>> getPodcasts() {
    return _podcast.getPodcastList();
  }

  void playEpisode(Episode episode) {
    player.playEpisode(episode);
  }

  Future<Podcast> podcastURL(String url) async {
    final feed = RssFeed.parse(await _web.getAsString(url));
    return Podcast.fromFeed(url, feed);
  }

  Future<Podcast> addPodcast(String url) async {
    final feed = RssFeed.parse(await _web.getAsString(url));
    final podcast = await _podcast.addPodcastFeed(url, feed);
    _storage.downloadImage(podcast);
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
    final feed = RssFeed.parse(await _web.getAsString(podcast.rssUrl));
    return _podcast.updatePodcast(podcast, feed);
  }

  Stream<List<Episode>> episodeList(Podcast podcast) {
    return _podcast.getEpisodeList(podcast);
  }

  Stream<List<Playlist>> getPlaylists() {
    return _playlist.getPlaylistList();
  }

  Stream<List<Episode>> getPlaylistEpisodes(Playlist playlist) {
    return _playlist.getPlaylist(playlist);
  }

  void addPlaylist(String text) {
    _playlist.addPlaylist(text);
  }

  // Only for testing
  void addRandom(Playlist playlist) async {
    Episode? episode = await _podcast.getRandomEpisode();
    if (episode != null) {
      _playlist.addPlaylistEntry(playlist, episode);
    }
  }
}

class PlayerController {
  final _storage = StorageHandler();
  Episode episode = Episode.simple(
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
