import 'dart:async';

import 'package:lytt/podcast/podcast.dart';
import 'package:rxdart/rxdart.dart';

/// Library for managing podcasts
class PodcastLibrary {
  final Map<String, Podcast> _podcastMap = {};
  StreamController<List<Podcast>> controller = BehaviorSubject();

  PodcastLibrary() {
    _sendPodcastList();
  }

  List<Podcast> _podcastList() {
    final list = _podcastMap.values.toList();
    list.sort((a,b) => a.title.compareTo(b.title));
    return list;
  }

  void _sendPodcastList() {
    controller.add(_podcastList());
  }

  Stream<List<Podcast>> getPodcastStream() async* {
    yield* controller.stream;
  }

  Future<Podcast> addPodcast(Podcast podcast) async {
    _podcastMap[podcast.id] = podcast;
    _sendPodcastList();
    return podcast;
  }

  /// JSON methods
  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'podcasts': _podcastList(),
      };

  PodcastLibrary.fromJson(Map<String, dynamic> json) {
    final list = (json['podcasts'] as List<dynamic>)
        .map((e) => Podcast.fromJson(e as Map<String, dynamic>))
        .toList();
    for (Podcast p in list) {
      _podcastMap[p.title] = p;
    }
    _sendPodcastList();
  }
}
