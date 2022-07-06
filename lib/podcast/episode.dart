import 'package:floor/floor.dart';
import 'package:lytt/podcast/podcast.dart';
import 'package:webfeed/domain/rss_item.dart';

import '../manager/io_manager.dart';

@Entity(foreignKeys: [
  ForeignKey(
      childColumns: ["podcastId"], parentColumns: ["id"], entity: Podcast)
])
class Episode {
  @primaryKey
  late String id;

  late String url;
  late String title;

  String podcastId;

  String? description;
  bool? explicit;
  String? guid;
  String? durationString;
  String? pubDateString;

  Episode(this.url, this.title, this.podcastId, this.id, this.description,
      this.explicit, this.guid, this.durationString, this.pubDateString);

  Episode.simple(
    this.url,
    this.title,
    this.podcastId,
  ) {
    id = (guid ?? url).hashCode.toRadixString(32);
  }

  Episode.fromFeed(RssItem item, this.podcastId) {
    url = item.enclosure!.url!;
    title = item.title!;

    description = item.description ?? item.itunes?.summary;
    explicit = item.itunes?.explicit;
    guid = item.guid;
    durationString = item.itunes?.duration.toString();
    pubDateString = item.pubDate.toString();

    id = (guid ?? url).hashCode.toRadixString(32);
  }

  String get filename => '$id.${StorageHandler.urlFileName(url)}';
}
