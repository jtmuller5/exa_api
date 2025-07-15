// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find-similar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FindSimilarRequest _$FindSimilarRequestFromJson(Map<String, dynamic> json) =>
    FindSimilarRequest(
      url: json['url'] as String,
      numResults: (json['numResults'] as num?)?.toInt() ?? 10,
      includeDomains: (json['includeDomains'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      excludeDomains: (json['excludeDomains'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      startCrawlDate: json['startCrawlDate'] == null
          ? null
          : DateTime.parse(json['startCrawlDate'] as String),
      endCrawlDate: json['endCrawlDate'] == null
          ? null
          : DateTime.parse(json['endCrawlDate'] as String),
      startPublishedDate: json['startPublishedDate'] == null
          ? null
          : DateTime.parse(json['startPublishedDate'] as String),
      endPublishedDate: json['endPublishedDate'] == null
          ? null
          : DateTime.parse(json['endPublishedDate'] as String),
      includeText: (json['includeText'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      excludeText: (json['excludeText'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      context: json['context'] as bool?,
      contents: json['contents'] == null
          ? null
          : ContentsConfig.fromJson(json['contents'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FindSimilarRequestToJson(
  FindSimilarRequest instance,
) => <String, dynamic>{
  'url': instance.url,
  'numResults': instance.numResults,
  'includeDomains': instance.includeDomains,
  'excludeDomains': instance.excludeDomains,
  'startCrawlDate': FindSimilarRequest._dateTimeToJson(instance.startCrawlDate),
  'endCrawlDate': FindSimilarRequest._dateTimeToJson(instance.endCrawlDate),
  'startPublishedDate': FindSimilarRequest._dateTimeToJson(
    instance.startPublishedDate,
  ),
  'endPublishedDate': FindSimilarRequest._dateTimeToJson(
    instance.endPublishedDate,
  ),
  'includeText': instance.includeText,
  'excludeText': instance.excludeText,
  'context': instance.context,
  'contents': instance.contents,
};
