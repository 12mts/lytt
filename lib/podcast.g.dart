// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode(
      json['url'],
      json['name'],
    );

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'url': instance.url,
      'name': instance.name,
    };

Podcast _$PodcastFromJson(Map<String, dynamic> json) => Podcast(
      json['name'] as String,
      json['url'] as String,
    )..episodes = (json['episodes'] as List<dynamic>)
        .map((e) => Episode.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$PodcastToJson(Podcast instance) => <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
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
