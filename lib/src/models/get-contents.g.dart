// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get-contents.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentsRequest _$ContentsRequestFromJson(
  Map<String, dynamic> json,
) => ContentsRequest(
  urls: (json['urls'] as List<dynamic>).map((e) => e as String).toList(),
  ids: (json['ids'] as List<dynamic>?)?.map((e) => e as String).toList(),
  textConfig: json['textConfig'] == null
      ? null
      : TextConfig.fromJson(json['textConfig'] as Map<String, dynamic>),
  highlights: json['highlights'] == null
      ? null
      : HighlightsConfig.fromJson(json['highlights'] as Map<String, dynamic>),
  summary: json['summary'] == null
      ? null
      : SummaryConfig.fromJson(json['summary'] as Map<String, dynamic>),
  livecrawl: $enumDecodeNullable(_$LivecrawlOptionEnumMap, json['livecrawl']),
  livecrawlTimeout: (json['livecrawlTimeout'] as num?)?.toInt() ?? 10000,
  subpages: (json['subpages'] as num?)?.toInt() ?? 0,
  subpageTarget: json['subpageTarget'],
  extras: json['extras'] == null
      ? null
      : ExtrasConfig.fromJson(json['extras'] as Map<String, dynamic>),
  contextConfig: json['contextConfig'] == null
      ? null
      : ContextConfig.fromJson(json['contextConfig'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ContentsRequestToJson(ContentsRequest instance) =>
    <String, dynamic>{
      'urls': instance.urls,
      'ids': instance.ids,
      'textConfig': instance.textConfig,
      'highlights': instance.highlights,
      'summary': instance.summary,
      'livecrawl': _$LivecrawlOptionEnumMap[instance.livecrawl],
      'livecrawlTimeout': instance.livecrawlTimeout,
      'subpages': instance.subpages,
      'subpageTarget': instance.subpageTarget,
      'extras': instance.extras,
      'contextConfig': instance.contextConfig,
    };

const _$LivecrawlOptionEnumMap = {
  LivecrawlOption.never: 'never',
  LivecrawlOption.fallback: 'fallback',
  LivecrawlOption.always: 'always',
  LivecrawlOption.preferred: 'preferred',
};

ContentStatus _$ContentStatusFromJson(Map<String, dynamic> json) =>
    ContentStatus(
      id: json['id'] as String,
      status: json['status'] as String,
      error: json['error'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ContentStatusToJson(ContentStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'error': instance.error,
    };

ContentsResponse _$ContentsResponseFromJson(Map<String, dynamic> json) =>
    ContentsResponse(
      requestId: json['requestId'] as String,
      results: (json['results'] as List<dynamic>)
          .map((e) => SearchResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      context: json['context'] as String?,
      statuses: (json['statuses'] as List<dynamic>?)
          ?.map((e) => ContentStatus.fromJson(e as Map<String, dynamic>))
          .toList(),
      costDollars: json['costDollars'] == null
          ? null
          : CostDollars.fromJson(json['costDollars'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContentsResponseToJson(ContentsResponse instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'results': instance.results,
      'context': instance.context,
      'statuses': instance.statuses,
      'costDollars': instance.costDollars,
    };
