
import 'package:floor/floor.dart';
import 'package:lytt/podcast/podcast.dart';

import '../podcast/episode.dart';

@dao
abstract class PodcastDAO {
  @Query("SELECT * FROM Podcast")
  Stream<List<Podcast>> getPodcastStream();

  @Query("SELECT * FROM Episode WHERE podcastId = :podcastId")
  Stream<List<Episode>> getEpisodes(String podcastId);

  @insert
  Future<void> addPodcast(Podcast podcast);

  @update
  Future<void> updatePodcast(Podcast podcast);

  @insert
  Future<void> addEpisode(Episode episode);

  @Query("SELECT * FROM Episode WHERE id = :id")
  Future<Episode?> episode(String id);
}