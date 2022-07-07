import 'package:floor/floor.dart';
import 'package:lytt/podcast/playlist.dart';

import 'episode.dart';

@Entity(primaryKeys: [
  'episodeId',
  'playlistName'
], foreignKeys: [
  ForeignKey(
      childColumns: ['playlistId'], parentColumns: ['id'], entity: Playlist),
  ForeignKey(
      childColumns: ['episodeId'], parentColumns: ['id'], entity: Episode),
])
class PlaylistEntry {
  final String playlistId;
  final String episodeId;
  int rank;

  PlaylistEntry(this.playlistId, this.episodeId, this.rank);
}
