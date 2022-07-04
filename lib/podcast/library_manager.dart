import 'dart:async';

import 'package:lytt/podcast/podcast.dart';
import 'package:lytt/podcast/podcast_library.dart';
import 'package:rxdart/rxdart.dart';

class PodcastManager {
  late PodcastLibrary podcastLibrary;
  StreamController<List<Podcast>> controller = BehaviorSubject();

  PodcastManager() {
    podcastLibrary = PodcastLibrary();
    _sendPodcastList();
  }

  PodcastManager.fromJson(Map<String, dynamic> json) {
    podcastLibrary = PodcastLibrary.fromJson(json);
    _sendPodcastList();
  }

  PodcastLibrary get lib => podcastLibrary;

  void _sendPodcastList() {
    controller.add(podcastLibrary.podcastList());
  }

  Stream<List<Podcast>> getPodcastStream() async* {
    yield* controller.stream;
  }

  Future<Podcast> addPodcast(Podcast podcast) async {
    final pod = podcastLibrary.addPodcast(podcast);
    _sendPodcastList();
    return pod;
  }
}
