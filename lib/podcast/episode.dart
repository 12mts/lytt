
import 'package:json_annotation/json_annotation.dart';
import 'package:webfeed/domain/rss_item.dart';

import '../io_manager.dart';

part 'episode.g.dart';

@JsonSerializable()
class Episode {
  late String url;
  late String title;
  String podcastTitle;

  String? description;
  bool? explicit;
  String? guid;
  Duration? duration;
  DateTime? pubDate;

  Episode(this.url, this.title, this.podcastTitle);

  void download() {
    final storage = StorageHandler();
    storage.downloadFile(this);
  }

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

  Future<Uri> uri() async {
    final storage = StorageHandler();
    return storage.episodeUri(this);
  }
}