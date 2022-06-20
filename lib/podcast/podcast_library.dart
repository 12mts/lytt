import 'dart:async';

import 'package:json_annotation/json_annotation.dart';

import 'package:lytt/podcast/podcast.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webfeed/webfeed.dart';

part 'podcast_library.g.dart';

/// Library for managing podcasts
@JsonSerializable()
class PodcastLibrary {
  List<Podcast> _podcasts = [];
  StreamController<List<Podcast>> controller = BehaviorSubject();

  PodcastLibrary() {
    controller.add(_podcasts);
  }

  PodcastLibrary.fromJson(Map<String, dynamic> json) {
    _podcasts = (json['podcasts'] as List<dynamic>)
        .map((e) => Podcast.fromJson(e as Map<String, dynamic>))
        .toList();
    controller.add(_podcasts);
  }

  Stream<List<Podcast>> getPodcastStream() async* {
    yield* controller.stream;
  }

  Future<Podcast> addPodcast(Future<String> rss) async {
    final podcast = Podcast.fromFeed(RssFeed.parse(await rss));
    _podcasts.add(podcast);
    controller.add(_podcasts);
    return podcast;
  }

  /// JSON methods
  Map<String, dynamic> toJson() => _$PodcastLibraryToJson(this);
}
