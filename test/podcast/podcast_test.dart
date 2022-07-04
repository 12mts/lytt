
import 'package:flutter_test/flutter_test.dart';
import 'package:lytt/podcast/podcast.dart';
import 'package:webfeed/domain/rss_feed.dart';

import '../io_thing.dart';

void main() {
  late Podcast podcast;

  group('finished', () {
    setUp(() async {
      podcast = Podcast.fromFeed("", RssFeed.parse(await getFileAsString("helloInternet")));
    });

    test('Get list', () {
      final list = podcast.episodeList;
      expect(list, isNot(null));
      expect(list.length, 2);
    });

    test('Get id', () {
      expect(podcast.id, "1");
    });
  });

  test('Update', () async {
    var feed = RssFeed.parse(await getFileAsString("helloInternet_pri"));
    podcast = Podcast.fromFeed("url", feed);
    expect(podcast.episodeList.length, 1);
    expect(await podcast.updatePodcast(feed), false);
    expect(podcast.episodeList.length, 1);
    expect(podcast.rssUrl, "url");
    feed = RssFeed.parse(await getFileAsString("helloInternet"));
    expect(await podcast.updatePodcast(feed), true);
    expect(podcast.episodeList.length, 2);
    expect(podcast.rssUrl, "url");
    feed = RssFeed.parse(await getFileAsString("helloInternet_new"));
    expect(await podcast.updatePodcast(feed), true);
    expect(podcast.episodeList.length, 2);
    expect(podcast.rssUrl, "newUrl");
  });
}