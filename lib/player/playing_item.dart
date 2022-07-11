
import 'package:lytt/DAO/playlist_dao.dart';
import 'package:lytt/podcast/episode.dart';
import 'package:lytt/podcast/playlist.dart';

abstract class PlayingItem {
  Future<String> get url async => (await getCurrentEpisode())?.url ?? "";

  Future<Episode?> getCurrentEpisode();
  Future<Episode?> getGetNext();
}

class PlayingEpisode implements PlayingItem {
  Episode? episode;
  PlayingEpisode(this.episode);

  @override
  Future<Episode?> getCurrentEpisode() async {
    return episode;
  }

  @override
  Future<Episode?> getGetNext() async {
    return episode = null;
  }

  @override
  Future<String> get url async => (await getCurrentEpisode())?.url ?? "";

}

class PlayingPlaylist implements PlayingItem {
  Playlist playlist;
  PlaylistManager playlistManager;
  late Stream<List<Episode>> episodes;
  PlayingPlaylist(this.playlist, this.playlistManager) {
    episodes = playlistManager.getPlaylist(playlist);
  }

  @override
  Future<Episode?> getCurrentEpisode() async {
    final list = await episodes.first;
    return list.isEmpty ? null : list.first;
  }

  @override
  Future<Episode?> getGetNext() async {
    final current = await getCurrentEpisode();
    if (current == null) return null;
    await playlistManager.removeEpisode(playlist, current);
    return getCurrentEpisode();
  }

  @override
  Future<String> get url async => (await getCurrentEpisode())?.url ?? "";
}

class PlayingNull extends PlayingItem {
  @override
  Future<Episode?> getCurrentEpisode() async {
    return null;
  }

  @override
  Future<Episode?> getGetNext() async {
    return null;
  }
}

