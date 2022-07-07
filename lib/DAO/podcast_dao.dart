import 'package:floor/floor.dart';
import 'package:lytt/podcast/podcast.dart';
import 'package:webfeed/domain/rss_feed.dart';

import '../podcast/episode.dart';
import 'database.dart';

class PodcastManager {
  late PodcastDAO _dao;

  PodcastManager(PodcastDatabase db) {
    _dao = db.podcastDao;
  }

  Stream<List<Podcast>> getPodcastList() {
    return _dao.getPodcastList();
  }

  Future<Podcast> addPodcastFeed(url, RssFeed feed) async {
    final podcast = Podcast.fromFeed(url, feed);
    _dao.addPodcast(podcast);
    for (var ep in feed.items!) {
      _dao.addEpisode(Episode.fromFeed(ep, podcast.id));
    }
    return podcast;
  }

  Future<bool> updatePodcast(Podcast podcast, RssFeed feed) async {
    final newPodcast = Podcast.fromFeed(podcast.rssUrl, feed);
    if (newPodcast.lastBuildDate != null &&
        newPodcast.lastBuildDate == podcast.lastBuildDate) {
      return false;
    }
    _dao.updatePodcast(newPodcast);
    for (var ep in feed.items!) {
      var episode = Episode.fromFeed(ep, podcast.id);
      if (await _dao.getEpisode(episode.id) == null) {
        _dao.addEpisode(episode);
      }
    }
    return true;
  }

  Stream<List<Episode>> getEpisodeList(Podcast podcast) {
    return _dao.getEpisodes(podcast.id);
  }

  Future<Episode?> getRandomEpisode() {
    return _dao.getRandomEpisode();
  }
}

@dao
abstract class PodcastDAO {
  @Query("SELECT * FROM Podcast")
  Stream<List<Podcast>> getPodcastList();

  @Query("SELECT * FROM Episode WHERE podcastId = :podcastId")
  Stream<List<Episode>> getEpisodes(String podcastId);

  @insert
  Future<void> addPodcast(Podcast podcast);

  @update
  Future<void> updatePodcast(Podcast podcast);

  @insert
  Future<void> addEpisode(Episode episode);

  @Query("SELECT * FROM Episode WHERE id = :id")
  Future<Episode?> getEpisode(String id);

  @Query("SELECT * FROM Episode ORDER BY RANDOM() LIMIT 1")
  Future<Episode?> getRandomEpisode();
}
