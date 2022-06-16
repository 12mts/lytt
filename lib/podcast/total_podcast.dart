import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'package:lytt/io_manager.dart';
import 'package:lytt/podcast/podcast.dart';
import 'package:webfeed/webfeed.dart';

part 'total_podcast.g.dart';

/// Library for managing podcasts
@JsonSerializable()
class PodcastLibrary {
  List<Podcast> podcasts = [];
  final storage = StorageHandler();

  PodcastLibrary() {
    loadPodcast();
  }

  void loadPodcast() async {
    try {
      podcasts = PodcastLibrary
          .fromJson(jsonDecode(await storage.readString()))
          .podcasts;
    } catch (e) {
      // ok
    }
  }

  Future<List<Podcast>> getPodcasts() async {
    return podcasts;
  }

  void addPodcast(url) async {
    podcasts.add(await _createPodcast(url));
    storage.writeString(jsonEncode(this));
  }

  Future<Podcast> _createPodcast(String url) async {
    var feed = RssFeed.parse(await WebHandler().getAsString(url));

    return Podcast.fromFeed(feed);
  }

  /// JSON methods
  factory PodcastLibrary.fromJson(Map<String, dynamic> json) => _$PodcastLibraryFromJson(json);
  Map<String, dynamic> toJson() => _$PodcastLibraryToJson(this);
}
