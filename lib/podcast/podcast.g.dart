// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Podcast _$PodcastFromJson(Map<String, dynamic> json) => Podcast(
      title: json['title'] as String,
      link: json['link'] as String,
      image: json['image'] as String,
      rssUrl: json['rssUrl'] as String,
      description: json['description'] as String?,
      owner: json['owner'] as String?,
      author: json['author'] as String?,
      lastBuildDate: json['lastBuildDate'] as String?,
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
