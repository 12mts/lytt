import 'package:floor/floor.dart';
import 'package:webfeed/domain/rss_feed.dart';

@Entity()
class Podcast {
  @PrimaryKey()
  late String id;

  /// Must
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
  }
}
