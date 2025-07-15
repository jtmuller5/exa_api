// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextConfig _$TextConfigFromJson(Map<String, dynamic> json) => TextConfig(
  maxCharacters: (json['maxCharacters'] as num?)?.toInt(),
  includeHtmlTags: json['includeHtmlTags'] as bool? ?? false,
);

Map<String, dynamic> _$TextConfigToJson(TextConfig instance) =>
    <String, dynamic>{
      'maxCharacters': instance.maxCharacters,
      'includeHtmlTags': instance.includeHtmlTags,
    };

HighlightsConfig _$HighlightsConfigFromJson(Map<String, dynamic> json) =>
    HighlightsConfig(
      numSentences: (json['numSentences'] as num?)?.toInt() ?? 5,
      highlightsPerUrl: (json['highlightsPerUrl'] as num?)?.toInt() ?? 1,
      query: json['query'] as String?,
    );

Map<String, dynamic> _$HighlightsConfigToJson(HighlightsConfig instance) =>
    <String, dynamic>{
      'numSentences': instance.numSentences,
      'highlightsPerUrl': instance.highlightsPerUrl,
      'query': instance.query,
    };

SummaryConfig _$SummaryConfigFromJson(Map<String, dynamic> json) =>
    SummaryConfig(
      query: json['query'] as String?,
      schema: json['schema'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SummaryConfigToJson(SummaryConfig instance) =>
    <String, dynamic>{'query': instance.query, 'schema': instance.schema};

ExtrasConfig _$ExtrasConfigFromJson(Map<String, dynamic> json) => ExtrasConfig(
  links: (json['links'] as num?)?.toInt() ?? 0,
  imageLinks: (json['imageLinks'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ExtrasConfigToJson(ExtrasConfig instance) =>
    <String, dynamic>{
      'links': instance.links,
      'imageLinks': instance.imageLinks,
    };

ContextConfig _$ContextConfigFromJson(Map<String, dynamic> json) =>
    ContextConfig(maxCharacters: (json['maxCharacters'] as num?)?.toInt());

Map<String, dynamic> _$ContextConfigToJson(ContextConfig instance) =>
    <String, dynamic>{'maxCharacters': instance.maxCharacters};

ContentsConfig _$ContentsConfigFromJson(
  Map<String, dynamic> json,
) => ContentsConfig(
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

Map<String, dynamic> _$ContentsConfigToJson(ContentsConfig instance) =>
    <String, dynamic>{
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

SearchRequest _$SearchRequestFromJson(Map<String, dynamic> json) =>
    SearchRequest(
      query: json['query'] as String,
      type:
          $enumDecodeNullable(_$SearchTypeEnumMap, json['type']) ??
          SearchType.auto,
      category: $enumDecodeNullable(_$SearchCategoryEnumMap, json['category']),
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
  'contents': instance.contents,
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
    CostBreakdown(
      search: (json['search'] as num).toDouble(),
      contents: (json['contents'] as num).toDouble(),
      breakdown: (json['breakdown'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$CostBreakdownToJson(CostBreakdown instance) =>
    <String, dynamic>{
      'search': instance.search,
      'contents': instance.contents,
      'breakdown': instance.breakdown,
    };

CostDollars _$CostDollarsFromJson(Map<String, dynamic> json) => CostDollars(
  total: (json['total'] as num).toDouble(),
  breakDown: (json['breakDown'] as List<dynamic>)
      .map((e) => CostBreakdown.fromJson(e as Map<String, dynamic>))
      .toList(),
  perRequestPrices: (json['perRequestPrices'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, (e as num).toDouble()),
  ),
  perPagePrices: (json['perPagePrices'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, (e as num).toDouble()),
  ),
);

Map<String, dynamic> _$CostDollarsToJson(CostDollars instance) =>
    <String, dynamic>{
      'total': instance.total,
      'breakDown': instance.breakDown,
      'perRequestPrices': instance.perRequestPrices,
      'perPagePrices': instance.perPagePrices,
    };

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) => SearchResult(
  title: json['title'] as String,
  url: json['url'] as String,
  publishedDate: json['publishedDate'] == null
      ? null
      : DateTime.parse(json['publishedDate'] as String),
  author: json['author'] as String?,
  score: (json['score'] as num?)?.toDouble(),
  id: json['id'] as String,
  image: json['image'] as String?,
  favicon: json['favicon'] as String?,
  text: json['text'] as String?,
  highlights: (json['highlights'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  highlightScores: (json['highlightScores'] as List<dynamic>?)
      ?.map((e) => (e as num).toDouble())
      .toList(),
  summary: json['summary'] as String?,
  subpages: (json['subpages'] as List<dynamic>?)
      ?.map((e) => SearchResult.fromJson(e as Map<String, dynamic>))
      .toList(),
  extras: json['extras'] as Map<String, dynamic>?,
);

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
      'subpages': instance.subpages,
      'extras': instance.extras,
    };

SearchResponse _$SearchResponseFromJson(Map<String, dynamic> json) =>
    SearchResponse(
      requestId: json['requestId'] as String,
      resolvedSearchType: $enumDecode(
        _$SearchTypeEnumMap,
        json['resolvedSearchType'],
      ),
      results: (json['results'] as List<dynamic>)
          .map((e) => SearchResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      searchType: $enumDecodeNullable(_$SearchTypeEnumMap, json['searchType']),
      context: json['context'] as String?,
      costDollars: json['costDollars'] == null
          ? null
          : CostDollars.fromJson(json['costDollars'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchResponseToJson(SearchResponse instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'resolvedSearchType': _$SearchTypeEnumMap[instance.resolvedSearchType]!,
      'results': instance.results,
      'searchType': _$SearchTypeEnumMap[instance.searchType],
      'context': instance.context,
      'costDollars': instance.costDollars,
    };
