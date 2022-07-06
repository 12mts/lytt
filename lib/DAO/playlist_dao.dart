import 'package:floor/floor.dart';
import 'package:lytt/podcast/episode.dart';
import 'package:lytt/podcast/playlist.dart';
import 'package:lytt/podcast/playlistEntry.dart';

@dao
abstract class PlaylistDAO {
  @Query(
      'SELECT e.* FROM Episode AS e INNER JOIN PlaylistEntry AS l '
          'ON e.id=l.episodeId WHERE l.playlistId = :playlistId')
  Stream<List<Episode>> getPlaylist(String playlistId);

  @delete
  Future<void> deleteEpisode(PlaylistEntry playlistEntry);

  @insert
  Future<void> addPlaylistEntry(PlaylistEntry playlistEntry);

  @insert
  Future<void> addPlaylist(Playlist playlist);

  @Query("SELECT * FROM playlist")
  Stream<List<Playlist>> getPlaylists();
}
