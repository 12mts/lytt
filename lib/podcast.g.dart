// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode(
      json['url'] as String,
      json['title'] as String,
      json['podcastTitle'] as String,
    )
      ..description = json['description'] as String?
      ..explicit = json['explicit'] as bool?
      ..guid = json['guid'] as String?
      ..duration = json['duration'] == null
          ? null
          : Duration(microseconds: json['duration'] as int)
      ..pubDate = json['pubDate'] == null
          ? null
          : DateTime.parse(json['pubDate'] as String);

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'url': instance.url,
      'title': instance.title,
      'podcastTitle': instance.podcastTitle,
      'description': instance.description,
      'explicit': instance.explicit,
      'guid': instance.guid,
      'duration': instance.duration?.inMicroseconds,
      'pubDate': instance.pubDate?.toIso8601String(),
    };

Podcast _$PodcastFromJson(Map<String, dynamic> json) => Podcast(
      json['title'] as String,
      json['link'] as String,
      json['image'] as String,
      json['counter'] as int,
      json['description'] as String?,
      json['owner'] as String?,
      json['author'] as String?,
    )
      ..ownerEmail = json['ownerEmail'] as String?
      ..episodes = (json['episodes'] as List<dynamic>)
          .map((e) => Episode.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$PodcastToJson(Podcast instance) => <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
      'image': instance.image,
      'counter': instance.counter,
      'description': instance.description,
      'owner': instance.owner,
      'ownerEmail': instance.ownerEmail,
      'author': instance.author,
      'episodes': instance.episodes,
    };

PodcastLibrary _$PodcastLibraryFromJson(Map<String, dynamic> json) =>
    PodcastLibrary()
      ..podcasts = (json['podcasts'] as List<dynamic>)
          .map((e) => Podcast.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$PodcastLibraryToJson(PodcastLibrary instance) =>
    <String, dynamic>{
      'podcasts': instance.podcasts,
    };
