import 'package:json_annotation/json_annotation.dart';
import 'package:webfeed/domain/rss_feed.dart';

import 'episode.dart';

part 'podcast.g.dart';

@JsonSerializable()
class Podcast {
  /// Must
  late String id;
  String rssUrl;
  late String title;
  late String link;
  late String image;

  /// Strongly recommended
  String? description;
  String? owner;
  String? ownerEmail;
  String? author;

  String? lastBuildDate;

  /// Recommended (implemented later)
  /*
  String? category;
  bool? explicit;
  String? language;
   */

  Map<String, Episode> episodes = {};

  Podcast(
      {required this.title,
      required this.link,
      required this.image,
      required this.rssUrl,
      this.description,
      this.owner,
      this.author,
      this.lastBuildDate}) {
    id = rssUrl.hashCode.toRadixString(32);
  }

  Podcast.fromFeed(this.rssUrl, RssFeed feed) {
    id = rssUrl.hashCode.toRadixString(32);

    title = feed.title!;
    link = feed.link!;
    image = (feed.image?.url) ?? (feed.itunes!.image!.href!);

    description = feed.description ?? feed.itunes?.summary;
    owner = feed.itunes?.owner?.name;
    ownerEmail = feed.itunes?.owner?.email;
    author = feed.author ?? feed.itunes?.author;

    lastBuildDate = feed.lastBuildDate;

    for (var ep in feed.items!) {
      var episode = Episode.fromFeed(ep, id);
      episodes[episode.id] = episode;
    }
  }

  List<Episode> get episodeList {
    final list = episodes.values.toList();
    list.sort((a, b) =>
        -(b.pubDate != null ? (a.pubDate?.compareTo(b.pubDate!) ?? 0) : 0));
    return list;
  }

  Future<bool> updatePodcast(RssFeed feed) async {
    if (feed.lastBuildDate == lastBuildDate && lastBuildDate != null) {
      return false;
    }
    if (feed.itunes?.newFeedUrl != null) {
      rssUrl = feed.itunes!.newFeedUrl!;
    }

    title = feed.title!;
    link = feed.link!;
    image = (feed.image?.url) ?? (feed.itunes!.image!.href!);

    description = feed.description ?? feed.itunes?.summary;
    owner = feed.itunes?.owner?.name;
    ownerEmail = feed.itunes?.owner?.email;
    author = feed.author ?? feed.itunes?.author;

    lastBuildDate = feed.lastBuildDate;

    for (var ep in feed.items!) {
      var episode = Episode.fromFeed(ep, id);

      /// dose not update episodes at this point
      if (!episodes.containsKey(episode.id)) {
        episodes[episode.id] = episode;
      }
    }

    return true;
  }

  /// JSON methods
  factory Podcast.fromJson(Map<String, dynamic> json) =>
      _$PodcastFromJson(json);

  Map<String, dynamic> toJson() => _$PodcastToJson(this);
}
