// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode(
      json['url'] as String,
      json['title'] as String,
      json['podcastId'] as String,
    )
      ..duration = Duration(microseconds: json['duration'] as int)
      ..played = Duration(microseconds: json['played'] as int)
      ..description = json['description'] as String?
      ..explicit = json['explicit'] as bool?
      ..guid = json['guid'] as String?
      ..pubDate = json['pubDate'] == null
          ? null
          : DateTime.parse(json['pubDate'] as String);

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'url': instance.url,
      'title': instance.title,
      'podcastId': instance.podcastId,
      'duration': instance.duration.inMicroseconds,
      'played': instance.played.inMicroseconds,
      'description': instance.description,
      'explicit': instance.explicit,
      'guid': instance.guid,
      'pubDate': instance.pubDate?.toIso8601String(),
    };
