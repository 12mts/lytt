
import 'package:json_annotation/json_annotation.dart';
import 'package:webfeed/domain/rss_item.dart';

part 'episode.g.dart';

@JsonSerializable()
class Episode {
  late String url;
  late String title;
  String podcastTitle;
  bool downloaded = false;

  String? description;
  bool? explicit;
  String? guid;
  Duration? duration;
  DateTime? pubDate;

  Episode(this.url, this.title, this.podcastTitle);

  Episode.fromFeed(RssItem item, this.podcastTitle) {
    url = item.enclosure!.url!;
    title = item.title!;

    description = item.description ?? item.itunes?.summary;
    explicit = item.itunes?.explicit;
    guid = item.guid;
    duration = item.itunes?.duration;
    pubDate = item.pubDate;
  }

  /// JSON methods
  factory Episode.fromJson(Map<String, dynamic> json) => _$EpisodeFromJson(json);
  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}