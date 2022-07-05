import 'dart:async';

import 'package:json_annotation/json_annotation.dart';
import 'package:lytt/podcast/podcast.dart';

part 'podcast_library.g.dart';

@JsonSerializable()
class PodcastLibrary {
  late Map<String, Podcast> podcastMap;

  PodcastLibrary() {
    podcastMap = {};
  }

  List<Podcast> podcastList() {
    final list = podcastMap.values.toList();
    list.sort((a,b) => a.title.compareTo(b.title));
    return list;
  }

  Future<Podcast> addPodcast(Podcast podcast) async {
    podcastMap[podcast.id] = podcast;
    return podcast;
  }

  /// JSON methods
  factory PodcastLibrary.fromJson(Map<String, dynamic> json) =>
      _$PodcastLibraryFromJson(json);
  Map<String, dynamic> toJson() => _$PodcastLibraryToJson(this);
}
