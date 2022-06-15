import 'dart:convert';

import 'package:http/io_client.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:lytt/storage_manager.dart';
import 'package:webfeed/webfeed.dart';

part 'podcast.g.dart';

@JsonSerializable()
class Episode {
  late String url;
  late String title;

  String? description;
  bool? explicit;
  String? guid;
  Duration? duration;
  DateTime? pubDate;

  Episode(this.url, this.title);

  Episode.fromFeed(RssItem item) {
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

@JsonSerializable()
class Podcast {
  /// Must
  late String title;
  late String link;
  late String image;

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

  Podcast(this.title, this.link, this.image, this.description, this.owner, this.author);

  Podcast.fromFeed(RssFeed feed) {
    title = feed.title!;
    link = feed.link!;
    image = (feed.image?.url)??(feed.itunes!.image!.href!);

    description = feed.description ?? feed.itunes?.summary;
    owner = feed.itunes?.owner?.name;
    ownerEmail = feed.itunes?.owner?.email;
    author = feed.author ?? feed.itunes?.author;

    for (var ep in feed.items!) {
      episodes.add(Episode.fromFeed(ep));
    }
  }

  void addEpisode(Episode e) {
    episodes.add(e);
  }

  /// JSON methods
  factory Podcast.fromJson(Map<String, dynamic> json) => _$PodcastFromJson(json);
  Map<String, dynamic> toJson() => _$PodcastToJson(this);
}

/// Library for managing podcasts
@JsonSerializable()
class PodcastLibrary {
  List<Podcast> podcasts = [];
  final storage = StorageHandler();

  PodcastLibrary() {
    loadPodcast();
  }

  void loadPodcast() async {
    podcasts = PodcastLibrary.fromJson(jsonDecode(await storage.readString())).podcasts;
  }

  Future<List<Podcast>> getPodcasts() async {
    return podcasts;
  }

  void addPodcast(url) async {
    podcasts.add(await _createPodcast(url));
    storage.writeString(jsonEncode(this));
  }

  Future<Podcast> _createPodcast(String url) async {
    final client = IOClient();
    var response = await client.get(Uri.parse(url));
    var feed = RssFeed.parse(response.body);

    return Podcast.fromFeed(feed);
  }

  /// JSON methods
  factory PodcastLibrary.fromJson(Map<String, dynamic> json) => _$PodcastLibraryFromJson(json);
  Map<String, dynamic> toJson() => _$PodcastLibraryToJson(this);
}
