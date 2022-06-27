import 'package:webfeed/domain/rss_feed.dart';

import 'episode.dart';

class Podcast {
  /// Must
  final String rssUrl;
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

  List<Episode> episodes = [];

  Podcast(this.title, this.link, this.image, this.rssUrl, this.description,
      this.owner, this.author, this.lastBuildDate);

  Podcast.fromFeed(this.rssUrl, RssFeed feed) {
    title = feed.title!;
    link = feed.link!;
    image = (feed.image?.url) ?? (feed.itunes!.image!.href!);

    description = feed.description ?? feed.itunes?.summary;
    owner = feed.itunes?.owner?.name;
    ownerEmail = feed.itunes?.owner?.email;
    author = feed.author ?? feed.itunes?.author;

    lastBuildDate = feed.lastBuildDate;

    for (var ep in feed.items!) {
      episodes.add(Episode.fromFeed(ep, id));
    }
  }

  void updatePodcast(RssFeed feed) {
    if (feed.lastBuildDate == lastBuildDate && lastBuildDate!=null) {
      return;
    }
    //TODO
  }

  String get id => (rssUrl.hashCode.toRadixString(32));

  /// JSON methods
  factory Podcast.fromJson(Map<String, dynamic> json) =>
      Podcast(
        json['title'] as String,
        json['link'] as String,
        json['image'] as String,
        json['rssUrl'] as String,
        json['description'] as String?,
        json['owner'] as String?,
        json['author'] as String?,
        json['lastBuildDate'] as String?,
      )
        ..ownerEmail = json['ownerEmail'] as String?
        ..episodes = (json['episodes'] as List<dynamic>)
            .map((e) => Episode.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => (<String, dynamic>{
    'title': title,
    'link': link,
    'image': image,
    'rssUrl': rssUrl,
    'description': description,
    'owner': owner,
    'ownerEmail': ownerEmail,
    'author': author,
    'episodes': episodes,
    'lastBuildDate': lastBuildDate
  });
}
