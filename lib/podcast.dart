import 'dart:convert';

import 'package:http/io_client.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:lytt/storage_manager.dart';
import 'package:webfeed/webfeed.dart';

part 'podcast.g.dart';

@JsonSerializable()
class Episode {
  var url;
  var name;

  Episode(this.url, this.name);

  /// JSON methods
  factory Episode.fromJson(Map<String, dynamic> json) => _$EpisodeFromJson(json);
  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}

@JsonSerializable()
class Podcast {
  String name;
  String url;
  List<Episode> episodes = [];

  Podcast(this.name, this.url);

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

    final pod = Podcast(feed.title ?? "-", url);
    var list = feed.items;
    if (list != null) {
      for (var ep in list) {
        pod.addEpisode(Episode(ep.enclosure?.url, ep.title));
      }
    }

    return pod;
  }

  /// JSON methods
  factory PodcastLibrary.fromJson(Map<String, dynamic> json) => _$PodcastLibraryFromJson(json);
  Map<String, dynamic> toJson() => _$PodcastLibraryToJson(this);
}
