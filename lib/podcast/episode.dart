import 'package:json_annotation/json_annotation.dart';
import 'package:webfeed/domain/rss_item.dart';

import '../manager/io_manager.dart';

part 'episode.g.dart';

@JsonSerializable()
class Episode {
  late String url;
  late String title;
  String podcastId;

  late Duration duration;
  Duration played = Duration.zero;

  String? description;
  bool? explicit;
  String? guid;
  DateTime? pubDate;

  Episode(this.url, this.title, this.podcastId) {
    duration = Duration.zero;
  }

  Episode.fromFeed(RssItem item, this.podcastId) {
    url = item.enclosure!.url!;
    title = item.title!;

    description = item.description ?? item.itunes?.summary;
    explicit = item.itunes?.explicit;
    guid = item.guid;
    duration = item.itunes?.duration ?? Duration.zero;
    pubDate = item.pubDate;
  }

  String get id => (guid ?? url).hashCode.toRadixString(32);

  String get filename => '$id.${StorageHandler.urlFileName(url)}';

  EpisodeState get episodeState => played == Duration.zero
      ? EpisodeState.notPlayed
      : (played == duration ? EpisodeState.finished : EpisodeState.started);

  /// JSON methods
  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}

enum EpisodeState { notPlayed, started, finished }
