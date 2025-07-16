// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextConfig _$TextConfigFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TextConfig', json, ($checkedConvert) {
      final val = TextConfig(
        maxCharacters: $checkedConvert(
          'maxCharacters',
          (v) => (v as num?)?.toInt(),
        ),
        includeHtmlTags: $checkedConvert(
          'includeHtmlTags',
          (v) => v as bool? ?? false,
        ),
      );
      return val;
    });

Map<String, dynamic> _$TextConfigToJson(TextConfig instance) =>
    <String, dynamic>{
      'maxCharacters': instance.maxCharacters,
      'includeHtmlTags': instance.includeHtmlTags,
    };

HighlightsConfig _$HighlightsConfigFromJson(Map<String, dynamic> json) =>
    $checkedCreate('HighlightsConfig', json, ($checkedConvert) {
      final val = HighlightsConfig(
        numSentences: $checkedConvert(
          'numSentences',
          (v) => (v as num?)?.toInt() ?? 5,
        ),
        highlightsPerUrl: $checkedConvert(
          'highlightsPerUrl',
          (v) => (v as num?)?.toInt() ?? 1,
        ),
        query: $checkedConvert('query', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$HighlightsConfigToJson(HighlightsConfig instance) =>
    <String, dynamic>{
      'numSentences': instance.numSentences,
      'highlightsPerUrl': instance.highlightsPerUrl,
      'query': instance.query,
    };

SummaryConfig _$SummaryConfigFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SummaryConfig', json, ($checkedConvert) {
      final val = SummaryConfig(
        query: $checkedConvert('query', (v) => v as String?),
        schema: $checkedConvert('schema', (v) => v as Map<String, dynamic>?),
      );
      return val;
    });

Map<String, dynamic> _$SummaryConfigToJson(SummaryConfig instance) =>
    <String, dynamic>{'query': instance.query, 'schema': instance.schema};

ExtrasConfig _$ExtrasConfigFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ExtrasConfig', json, ($checkedConvert) {
      final val = ExtrasConfig(
        links: $checkedConvert('links', (v) => (v as num?)?.toInt() ?? 0),
        imageLinks: $checkedConvert(
          'imageLinks',
          (v) => (v as num?)?.toInt() ?? 0,
        ),
      );
      return val;
    });

Map<String, dynamic> _$ExtrasConfigToJson(ExtrasConfig instance) =>
    <String, dynamic>{
      'links': instance.links,
      'imageLinks': instance.imageLinks,
    };

ContextConfig _$ContextConfigFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ContextConfig', json, ($checkedConvert) {
      final val = ContextConfig(
        maxCharacters: $checkedConvert(
          'maxCharacters',
          (v) => (v as num?)?.toInt(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$ContextConfigToJson(ContextConfig instance) =>
    <String, dynamic>{'maxCharacters': instance.maxCharacters};

ContentsConfig _$ContentsConfigFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ContentsConfig', json, ($checkedConvert) {
  final val = ContentsConfig(
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

Map<String, dynamic> _$ContentsConfigToJson(ContentsConfig instance) =>
    <String, dynamic>{
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

SearchRequest _$SearchRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SearchRequest', json, ($checkedConvert) {
      final val = SearchRequest(
        query: $checkedConvert('query', (v) => v as String),
        type: $checkedConvert(
          'type',
          (v) => $enumDecodeNullable(_$SearchTypeEnumMap, v) ?? SearchType.auto,
        ),
        category: $checkedConvert(
          'category',
          (v) => $enumDecodeNullable(_$SearchCategoryEnumMap, v),
        ),
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

Map<String, dynamic> _$SearchRequestToJson(
  SearchRequest instance,
) => <String, dynamic>{
  'query': instance.query,
  'type': _$SearchTypeEnumMap[instance.type]!,
  'category': SearchRequest._categoryToJson(instance.category),
  'numResults': instance.numResults,
  'includeDomains': instance.includeDomains,
  'excludeDomains': instance.excludeDomains,
  'startCrawlDate': SearchRequest._dateTimeToJson(instance.startCrawlDate),
  'endCrawlDate': SearchRequest._dateTimeToJson(instance.endCrawlDate),
  'startPublishedDate': SearchRequest._dateTimeToJson(
    instance.startPublishedDate,
  ),
  'endPublishedDate': SearchRequest._dateTimeToJson(instance.endPublishedDate),
  'includeText': instance.includeText,
  'excludeText': instance.excludeText,
  'context': instance.context,
  'contents': instance.contents?.toJson(),
};

const _$SearchTypeEnumMap = {
  SearchType.keyword: 'keyword',
  SearchType.neural: 'neural',
  SearchType.auto: 'auto',
};

const _$SearchCategoryEnumMap = {
  SearchCategory.company: 'company',
  SearchCategory.researchPaper: 'research paper',
  SearchCategory.news: 'news',
  SearchCategory.pdf: 'pdf',
  SearchCategory.github: 'github',
  SearchCategory.tweet: 'tweet',
  SearchCategory.personalSite: 'personal site',
  SearchCategory.linkedinProfile: 'linkedin profile',
  SearchCategory.financialReport: 'financial report',
};

CostBreakdown _$CostBreakdownFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CostBreakdown', json, ($checkedConvert) {
      final val = CostBreakdown(
        search: $checkedConvert('search', (v) => (v as num).toDouble()),
        contents: $checkedConvert('contents', (v) => (v as num).toDouble()),
        breakdown: $checkedConvert(
          'breakdown',
          (v) => (v as Map<String, dynamic>).map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CostBreakdownToJson(CostBreakdown instance) =>
    <String, dynamic>{
      'search': instance.search,
      'contents': instance.contents,
      'breakdown': instance.breakdown,
    };

CostDollars _$CostDollarsFromJson(Map<String, dynamic> json) =>
    $checkedCreate('CostDollars', json, ($checkedConvert) {
      final val = CostDollars(
        total: $checkedConvert('total', (v) => (v as num?)?.toDouble()),
        breakDown: $checkedConvert(
          'breakDown',
          (v) => (v as List<dynamic>?)
              ?.map((e) => CostBreakdown.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        perRequestPrices: $checkedConvert(
          'perRequestPrices',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ),
        ),
        perPagePrices: $checkedConvert(
          'perPagePrices',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CostDollarsToJson(CostDollars instance) =>
    <String, dynamic>{
      'total': instance.total,
      'breakDown': instance.breakDown?.map((e) => e.toJson()).toList(),
      'perRequestPrices': instance.perRequestPrices,
      'perPagePrices': instance.perPagePrices,
    };

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SearchResult', json, ($checkedConvert) {
      final val = SearchResult(
        title: $checkedConvert('title', (v) => v as String),
        url: $checkedConvert('url', (v) => v as String),
        publishedDate: $checkedConvert(
          'publishedDate',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        author: $checkedConvert('author', (v) => v as String?),
        score: $checkedConvert('score', (v) => (v as num?)?.toDouble()),
        id: $checkedConvert('id', (v) => v as String),
        image: $checkedConvert('image', (v) => v as String?),
        favicon: $checkedConvert('favicon', (v) => v as String?),
        text: $checkedConvert('text', (v) => v as String?),
        highlights: $checkedConvert(
          'highlights',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
        ),
        highlightScores: $checkedConvert(
          'highlightScores',
          (v) =>
              (v as List<dynamic>?)?.map((e) => (e as num).toDouble()).toList(),
        ),
        summary: $checkedConvert('summary', (v) => v as String?),
        subpages: $checkedConvert(
          'subpages',
          (v) => (v as List<dynamic>?)
              ?.map((e) => SearchResult.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        extras: $checkedConvert('extras', (v) => v as Map<String, dynamic>?),
      );
      return val;
    });

Map<String, dynamic> _$SearchResultToJson(SearchResult instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'publishedDate': instance.publishedDate?.toIso8601String(),
      'author': instance.author,
      'score': instance.score,
      'id': instance.id,
      'image': instance.image,
      'favicon': instance.favicon,
      'text': instance.text,
      'highlights': instance.highlights,
      'highlightScores': instance.highlightScores,
      'summary': instance.summary,
      'subpages': instance.subpages?.map((e) => e.toJson()).toList(),
      'extras': instance.extras,
    };

SearchResponse _$SearchResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SearchResponse', json, ($checkedConvert) {
      final val = SearchResponse(
        requestId: $checkedConvert('requestId', (v) => v as String),
        resolvedSearchType: $checkedConvert(
          'resolvedSearchType',
          (v) => $enumDecodeNullable(_$SearchTypeEnumMap, v),
        ),
        results: $checkedConvert(
          'results',
          (v) => (v as List<dynamic>)
              .map((e) => SearchResult.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        searchType: $checkedConvert(
          'searchType',
          (v) => $enumDecodeNullable(_$SearchTypeEnumMap, v),
        ),
        context: $checkedConvert('context', (v) => v as String?),
        costDollars: $checkedConvert(
          'costDollars',
          (v) => v == null
              ? null
              : CostDollars.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SearchResponseToJson(SearchResponse instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'resolvedSearchType': _$SearchTypeEnumMap[instance.resolvedSearchType],
      'results': instance.results.map((e) => e.toJson()).toList(),
      'searchType': _$SearchTypeEnumMap[instance.searchType],
      'context': instance.context,
      'costDollars': instance.costDollars?.toJson(),
    };
