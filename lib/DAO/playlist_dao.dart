import 'package:floor/floor.dart';
import 'package:lytt/DAO/database.dart';
import 'package:lytt/podcast/episode.dart';
import 'package:lytt/podcast/playlist.dart';
import 'package:lytt/podcast/playlistEntry.dart';

class PlaylistManager {
  late PlaylistDAO _dao;

  PlaylistManager(PodcastDatabase db) {
    _dao = db.playlistDao;
  }

  Stream<List<Playlist>> getPlaylistList() {
    return _dao.getPlaylistList();
  }

  Stream<List<Episode>> getPlaylist(Playlist playlist) {
    return _dao.getPlaylist(playlist.id);
  }

  void addPlaylist(String text) {
    _dao.addPlaylist(Playlist.name(text));
  }

  void addPlaylistEntry(Playlist playlist, Episode episode) async {
    _dao.addPlaylistEntry(PlaylistEntry(
        playlist.id, episode.id, await _getAndIncrement(playlist)));
  }

  Future<int> _getAndIncrement(Playlist playlist) async {
    final rank = playlist.getNextRank();
    await _dao.updatePlaylist(playlist);
    return rank;
  }
}

@dao
abstract class PlaylistDAO {
  @Query('SELECT e.* FROM Episode AS e INNER JOIN PlaylistEntry AS l '
      'ON e.id=l.episodeId WHERE l.playlistId = :playlistId')
  Stream<List<Episode>> getPlaylist(String playlistId);

  @delete
  Future<void> deleteEpisode(PlaylistEntry playlistEntry);

  @insert
  Future<void> addPlaylistEntry(PlaylistEntry playlistEntry);

  @insert
  Future<void> addPlaylist(Playlist playlist);

  @Query("SELECT * FROM playlist")
  Stream<List<Playlist>> getPlaylistList();

  @update
  Future<void> updatePlaylist(Playlist playlist);
}
