// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'find-similar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FindSimilarRequest _$FindSimilarRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('FindSimilarRequest', json, ($checkedConvert) {
      final val = FindSimilarRequest(
        url: $checkedConvert('url', (v) => v as String),
        numResults: $checkedConvert(
          'numResults',
          (v) => (v as num?)?.toInt() ?? 10,
        ),
        includeDomains: $checkedConvert(
          'includeDomains',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        excludeDomains: $checkedConvert(
          'excludeDomains',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        startCrawlDate: $checkedConvert(
          'startCrawlDate',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        endCrawlDate: $checkedConvert(
          'endCrawlDate',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        startPublishedDate: $checkedConvert(
          'startPublishedDate',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        endPublishedDate: $checkedConvert(
          'endPublishedDate',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        includeText: $checkedConvert(
          'includeText',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        excludeText: $checkedConvert(
          'excludeText',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        context: $checkedConvert('context', (v) => v as bool?),
        contents: $checkedConvert(
          'contents',
          (v) => v == null
              ? null
              : ContentsConfig.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

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
  'contents': instance.contents?.toJson(),
};
