// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get-contents.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentsRequest _$ContentsRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ContentsRequest', json, ($checkedConvert) {
  final val = ContentsRequest(
    urls: $checkedConvert(
      'urls',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
    ids: $checkedConvert(
      'ids',
      (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
    ),
    textConfig: $checkedConvert(
      'textConfig',
      (v) => v == null ? null : TextConfig.fromJson(v as Map<String, dynamic>),
    ),
    highlights: $checkedConvert(
      'highlights',
      (v) => v == null
          ? null
          : HighlightsConfig.fromJson(v as Map<String, dynamic>),
    ),
    summary: $checkedConvert(
      'summary',
      (v) =>
          v == null ? null : SummaryConfig.fromJson(v as Map<String, dynamic>),
    ),
    livecrawl: $checkedConvert(
      'livecrawl',
      (v) => $enumDecodeNullable(_$LivecrawlOptionEnumMap, v),
    ),
    livecrawlTimeout: $checkedConvert(
      'livecrawlTimeout',
      (v) => (v as num?)?.toInt() ?? 10000,
    ),
    subpages: $checkedConvert('subpages', (v) => (v as num?)?.toInt() ?? 0),
    subpageTarget: $checkedConvert('subpageTarget', (v) => v),
    extras: $checkedConvert(
      'extras',
      (v) =>
          v == null ? null : ExtrasConfig.fromJson(v as Map<String, dynamic>),
    ),
    contextConfig: $checkedConvert(
      'contextConfig',
      (v) =>
          v == null ? null : ContextConfig.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$ContentsRequestToJson(ContentsRequest instance) =>
    <String, dynamic>{
      'urls': instance.urls,
      'ids': instance.ids,
      'textConfig': instance.textConfig?.toJson(),
      'highlights': instance.highlights?.toJson(),
      'summary': instance.summary?.toJson(),
      'livecrawl': _$LivecrawlOptionEnumMap[instance.livecrawl],
      'livecrawlTimeout': instance.livecrawlTimeout,
      'subpages': instance.subpages,
      'subpageTarget': instance.subpageTarget,
      'extras': instance.extras?.toJson(),
      'contextConfig': instance.contextConfig?.toJson(),
    };

const _$LivecrawlOptionEnumMap = {
  LivecrawlOption.never: 'never',
  LivecrawlOption.fallback: 'fallback',
  LivecrawlOption.always: 'always',
  LivecrawlOption.preferred: 'preferred',
};

ContentStatus _$ContentStatusFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ContentStatus', json, ($checkedConvert) {
      final val = ContentStatus(
        id: $checkedConvert('id', (v) => v as String),
        status: $checkedConvert('status', (v) => v as String),
        error: $checkedConvert('error', (v) => v as Map<String, dynamic>?),
      );
      return val;
    });

Map<String, dynamic> _$ContentStatusToJson(ContentStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'error': instance.error,
    };

ContentsResponse _$ContentsResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ContentsResponse', json, ($checkedConvert) {
      final val = ContentsResponse(
        requestId: $checkedConvert('requestId', (v) => v as String),
        results: $checkedConvert(
          'results',
          (v) => (v as List<dynamic>)
              .map((e) => SearchResult.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        context: $checkedConvert('context', (v) => v as String?),
        statuses: $checkedConvert(
          'statuses',
          (v) => (v as List<dynamic>?)
              ?.map((e) => ContentStatus.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        costDollars: $checkedConvert(
          'costDollars',
          (v) => v == null
              ? null
              : CostDollars.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ContentsResponseToJson(ContentsResponse instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'results': instance.results.map((e) => e.toJson()).toList(),
      'context': instance.context,
      'statuses': instance.statuses?.map((e) => e.toJson()).toList(),
      'costDollars': instance.costDollars?.toJson(),
    };
