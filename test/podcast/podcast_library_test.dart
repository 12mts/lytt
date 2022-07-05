import 'package:flutter_test/flutter_test.dart';
import 'package:lytt/podcast/podcast.dart';
import 'package:lytt/podcast/podcast_library.dart';

void main() {
  PodcastLibrary library = PodcastLibrary();

  setUpAll(() {
    library = PodcastLibrary();
    library.addPodcast(Podcast(
        title: "title", link: "link", image: "image", rssUrl: "rssUrl"));
  });

  test('Podcast list', () {
    expect(library.podcastList().length, 1);
    library.addPodcast(Podcast(
        title: "title2", link: "link2", image: "image2", rssUrl: "rssUrl2"));
    expect(library.podcastList().length, 2);
  });
}
