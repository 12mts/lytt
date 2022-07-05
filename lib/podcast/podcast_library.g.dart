// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast_library.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PodcastLibrary _$PodcastLibraryFromJson(Map<String, dynamic> json) =>
    PodcastLibrary()
      ..podcastMap = (json['podcastMap'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Podcast.fromJson(e as Map<String, dynamic>)),
      );

Map<String, dynamic> _$PodcastLibraryToJson(PodcastLibrary instance) =>
    <String, dynamic>{
      'podcastMap': instance.podcastMap,
    };
