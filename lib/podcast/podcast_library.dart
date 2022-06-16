import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'package:lytt/podcast/podcast.dart';
import 'package:webfeed/webfeed.dart';

part 'podcast_library.g.dart';

/// Library for managing podcasts
@JsonSerializable()
class PodcastLibrary {
  List<Podcast> podcasts = [];

  PodcastLibrary();

  void loadPodcast(Future<String> string) async {
    try {
      podcasts = PodcastLibrary
          .fromJson(jsonDecode(await string))
          .podcasts;
    } catch (e) {
      // ok
    }
  }

  Future<List<Podcast>> getPodcasts() async {
    return podcasts;
  }

  void addPodcast(Future<String> rss) async {
    var feed = RssFeed.parse(await rss);
    final pod = Podcast.fromFeed(feed);
    podcasts.add(pod);
  }

  /// JSON methods
  factory PodcastLibrary.fromJson(Map<String, dynamic> json) => _$PodcastLibraryFromJson(json);
  Map<String, dynamic> toJson() => _$PodcastLibraryToJson(this);
}
