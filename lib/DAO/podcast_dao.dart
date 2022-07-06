
import 'package:floor/floor.dart';
import 'package:lytt/podcast/podcast.dart';

import '../podcast/episode.dart';

@dao
abstract class PodcastDAO {
  @Query("SELECT * FROM Podcast")
  Stream<List<Podcast>> getPodcasts();

  Stream<List<Episode>> getEpisodes(Podcast podcast) {
    return getEpisodesId(podcast.id);
  }

  @Query("SELECT * FROM Episode WHERE podcastId = :podcastId")
  Stream<List<Episode>> getEpisodesId(String podcastId);

  @insert
  Future<void> addPodcast(Podcast podcast);

  @update
  Future<void> updatePodcast(Podcast podcast);

  @insert
  Future<void> addEpisode(Episode episode);

  Future<bool> episodeExists(Episode episode) async {
    return await getEpisode(episode.id) != null;
  }

  @Query("SELECT * FROM Episode WHERE id = :id")
  Future<Episode?> getEpisode(String id);

  @Query("SELECT * FROM Episode ORDER BY RANDOM() LIMIT 1")
  Future<Episode?> getRandomEpisode();
}