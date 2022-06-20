// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast_library.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PodcastLibrary _$PodcastLibraryFromJson(Map<String, dynamic> json) =>
    PodcastLibrary()
      .._podcasts = (json['podcasts'] as List<dynamic>)
          .map((e) => Podcast.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$PodcastLibraryToJson(PodcastLibrary instance) =>
    <String, dynamic>{
      'podcasts': instance._podcasts,
    };
