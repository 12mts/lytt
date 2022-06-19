import 'package:json_annotation/json_annotation.dart';

import 'package:lytt/podcast/podcast.dart';
import 'package:webfeed/webfeed.dart';

part 'podcast_library.g.dart';

/// Library for managing podcasts
@JsonSerializable()
class PodcastLibrary {
  List<Podcast> podcasts = [];

  PodcastLibrary();

  void loadPodcasts(Map<String, dynamic> json) {
    try {
      podcasts = PodcastLibrary.fromJson(json).podcasts;
    } catch (e) {
      // ok
    }
  }

  Future<List<Podcast>> getPodcasts() async {
    return podcasts;
  }

  Future<Podcast> addPodcast(Future<String> rss) async {
    final podcast = Podcast.fromFeed(RssFeed.parse(await rss));
    podcasts.add(podcast);
    return podcast;
  }

  /// JSON methods
  factory PodcastLibrary.fromJson(Map<String, dynamic> json) =>
      _$PodcastLibraryFromJson(json);
  Map<String, dynamic> toJson() => _$PodcastLibraryToJson(this);
}
