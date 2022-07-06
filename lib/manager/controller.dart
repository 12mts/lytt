import 'package:flutter/material.dart';
import 'package:lytt/DAO/playlist_dao.dart';
import 'package:lytt/player/player.dart';
import 'package:lytt/podcast/episode.dart';
import 'package:lytt/podcast/playlist.dart';
import 'package:lytt/podcast/playlistEntry.dart';
import 'package:lytt/podcast/podcast.dart';
import 'package:webfeed/domain/rss_feed.dart';

import '../DAO/database.dart';
import '../DAO/podcast_dao.dart';
import 'io_manager.dart';

class Controller {
  final _storage = StorageHandler();
  late final PodcastDAO _podcastDAO;
  late final PlaylistDAO _playlistDAO;
  final _web = WebHandler();
  late final PlayerController player;

  Controller() {
    $FloorPodcastDatabase.databaseBuilder('podcast.db').build().then((db) {
      _podcastDAO = db.podcastDao;
      _playlistDAO = db.playlistDao;
    });
    player = PlayerController(this);
  }

  Stream<List<Podcast>> getPodcasts() {
    return _podcastDAO.getPodcasts();
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
    final podcast = Podcast.fromFeed(url, feed);
    _podcastDAO.addPodcast(podcast);
    for (var ep in feed.items!) {
      _podcastDAO.addEpisode(Episode.fromFeed(ep, podcast.id));
    }
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
    // TODO not done properly
    final feed = RssFeed.parse(await _web.getAsString(podcast.rssUrl));
    final newPodcast = Podcast.fromFeed(podcast.rssUrl, feed);
    _podcastDAO.updatePodcast(newPodcast);
    for (var ep in feed.items!) {
      var episode = Episode.fromFeed(ep, podcast.id);
      if (!await _podcastDAO.episodeExists(episode)) {
        _podcastDAO.addEpisode(episode);
      }
    }
    return true;
  }

  Stream<List<Episode>> episodeList(Podcast podcast) {
    return _podcastDAO.getEpisodes(podcast);
  }

  Stream<List<Playlist>> getPlaylists() {
    return _playlistDAO.getPlaylists();
  }

  Stream<List<Episode>> getPlaylistEpisodes(Playlist playlist) {
    return _playlistDAO.getPlaylist(playlist.id);
  }

  void addPlaylist(String text) {
    _playlistDAO.addPlaylist(Playlist.name(text));
  }

  // Only for testing
  void addRandom(Playlist playlist) async {
    Episode? episode = await _podcastDAO.getRandomEpisode();
    if (episode != null) {
      _playlistDAO
          .addPlaylistEntry(PlaylistEntry(episode.id, playlist.id, playlist.counter));
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
