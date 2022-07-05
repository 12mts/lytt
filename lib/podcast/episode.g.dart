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
      ..finished = json['finished'] as bool
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
      'podcastId': instance.podcastId,
      'finished': instance.finished,
      'description': instance.description,
      'explicit': instance.explicit,
      'guid': instance.guid,
      'duration': instance.duration?.inMicroseconds,
      'pubDate': instance.pubDate?.toIso8601String(),
    };
