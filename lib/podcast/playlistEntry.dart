import 'package:floor/floor.dart';
import 'package:lytt/podcast/playlist.dart';

import 'episode.dart';

@Entity(primaryKeys: [
  'episodeId',
  'playlistName'
], foreignKeys: [
  ForeignKey(
      childColumns: ['episodeId'], parentColumns: ['id'], entity: Episode),
  ForeignKey(
      childColumns: ['playlistId'], parentColumns: ['id'], entity: Playlist)
])
class PlaylistEntry {
  final String episodeId;
  final String playlistId;
  int rank;

  PlaylistEntry(this.episodeId, this.playlistId, this.rank);
}
