// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
