import 'package:flutter_test/flutter_test.dart';
import 'package:lytt/manager/io_manager.dart';
import 'package:lytt/podcast/podcast.dart';
import 'package:webfeed/domain/rss_feed.dart';

import '../io_thing.dart';

void main() {
  late Podcast podcast;

  group('finished', () {
    setUp(() async {
      podcast = Podcast.fromFeed(
          "", RssFeed.parse(await getFileAsString("helloInternet")));
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

  test('Web update', () async {
    final web = WebHandler();
    var feed = RssFeed.parse(await web
        .getAsString("http://www.hellointernet.fm/podcast?format=rss"));
    podcast = Podcast.fromFeed("rssUrl", feed);
    feed = RssFeed.parse(await web
        .getAsString("http://www.hellointernet.fm/podcast?format=rss"));
    expect(await podcast.updatePodcast(feed), false);
  });

  test("rss file ÆØÅ", () async {
    podcast = Podcast.fromFeed(
        "rssUrl", RssFeed.parse(await getFileAsString("100153.xml")));
    expect(
        podcast.description
            ?.replaceAll(RegExp('\r\n'), '')
            .replaceAll(RegExp(' '), ''),
        "Ukesaktuelt nyhetsmagasin med lause snipp. Programledere er Aftenbladets journalister Jan Zahl og Leif Tore Lindø, som har med seg kommentator Harald Birkevold og forfatter og professor Janne Stigen Drangsholt. Publiseres hver onsdag. Følg Aftenbla-bla på Instagram: instagram.com/aftenblabla"
            .replaceAll(RegExp(' '), ''));
  });
}
