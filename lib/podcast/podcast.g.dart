// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Podcast _$PodcastFromJson(Map<String, dynamic> json) => Podcast(
      json['title'] as String,
      json['link'] as String,
      json['image'] as String,
      json['rssUrl'] as String,
      json['description'] as String?,
      json['owner'] as String?,
      json['author'] as String?,
      json['lastBuildDate'] as String?,
    )
      ..id = json['id'] as String
      ..ownerEmail = json['ownerEmail'] as String?
      ..episodes = (json['episodes'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Episode.fromJson(e as Map<String, dynamic>)),
      );

Map<String, dynamic> _$PodcastToJson(Podcast instance) => <String, dynamic>{
      'id': instance.id,
      'rssUrl': instance.rssUrl,
      'title': instance.title,
      'link': instance.link,
      'image': instance.image,
      'description': instance.description,
      'owner': instance.owner,
      'ownerEmail': instance.ownerEmail,
      'author': instance.author,
      'lastBuildDate': instance.lastBuildDate,
      'episodes': instance.episodes,
    };
