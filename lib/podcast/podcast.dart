
import 'package:json_annotation/json_annotation.dart';
import 'package:webfeed/domain/rss_feed.dart';

import 'episode.dart';

part 'podcast.g.dart';

@JsonSerializable()
class Podcast {
  /// Must
  late String title;
  late String link;
  late String image;
  int counter = 0;

  /// Strongly recommended
  String? description;
  String? owner;
  String? ownerEmail;
  String? author;

  /// Recommended (implemented later)
  /*
  String? category;
  bool? explicit;
  String? language;
   */

  List<Episode> episodes = [];

  Podcast(this.title, this.link, this.image, this.counter,
      this.description, this.owner, this.author);

  Podcast.fromFeed(RssFeed feed) {
    title = feed.title!;
    link = feed.link!;
    image = (feed.image?.url)??(feed.itunes!.image!.href!);

    description = feed.description ?? feed.itunes?.summary;
    owner = feed.itunes?.owner?.name;
    ownerEmail = feed.itunes?.owner?.email;
    author = feed.author ?? feed.itunes?.author;

    for (var ep in feed.items!) {
      episodes.add(Episode.fromFeed(ep, title));
    }
  }

  void addEpisode(Episode e) {
    episodes.add(e);
  }

  /// JSON methods
  factory Podcast.fromJson(Map<String, dynamic> json) => _$PodcastFromJson(json);
  Map<String, dynamic> toJson() => _$PodcastToJson(this);
}
