import 'dart:async';

import 'package:lytt/podcast/podcast.dart';

class PodcastLibrary {
  final Map<String, Podcast> podcastMap = {};

  PodcastLibrary();

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
  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'podcasts': podcastList(),
      };

  PodcastLibrary.fromJson(Map<String, dynamic> json) {
    final list = (json['podcasts'] as List<dynamic>)
        .map((e) => Podcast.fromJson(e as Map<String, dynamic>))
        .toList();
    for (Podcast p in list) {
      podcastMap[p.id] = p;
    }
  }
}
