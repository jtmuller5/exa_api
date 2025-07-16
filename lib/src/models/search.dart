import 'package:json_annotation/json_annotation.dart';

part 'search.g.dart';

/// Search type enumeration
enum SearchType {
  @JsonValue('keyword')
  keyword,
  @JsonValue('neural')
  neural,
  @JsonValue('auto')
  auto,
}

/// Category enumeration for search filtering
enum SearchCategory {
  @JsonValue('company')
  company,
  @JsonValue('research paper')
  researchPaper,
  @JsonValue('news')
  news,
  @JsonValue('pdf')
  pdf,
  @JsonValue('github')
  github,
  @JsonValue('tweet')
  tweet,
  @JsonValue('personal site')
  personalSite,
  @JsonValue('linkedin profile')
  linkedinProfile,
  @JsonValue('financial report')
  financialReport;

  String get apiValue {
    switch (this) {
      case SearchCategory.researchPaper:
        return 'research paper';
      case SearchCategory.personalSite:
        return 'personal site';
      case SearchCategory.linkedinProfile:
        return 'linkedin profile';
      case SearchCategory.financialReport:
        return 'financial report';
      default:
        return name;
    }
  }
}

/// Livecrawl options
enum LivecrawlOption {
  @JsonValue('never')
  never,
  @JsonValue('fallback')
  fallback,
  @JsonValue('always')
  always,
  @JsonValue('preferred')
  preferred,
}

/// Text content configuration
@JsonSerializable()
class TextConfig {
  const TextConfig({this.maxCharacters, this.includeHtmlTags = false});

  final int? maxCharacters;
  final bool includeHtmlTags;

  factory TextConfig.fromJson(Map<String, dynamic> json) =>
      _$TextConfigFromJson(json);
  Map<String, dynamic> toJson() => _$TextConfigToJson(this);
}

/// Highlights configuration
@JsonSerializable()
class HighlightsConfig {
  const HighlightsConfig({
    this.numSentences = 5,
    this.highlightsPerUrl = 1,
    this.query,
  });

  final int numSentences;
  final int highlightsPerUrl;
  final String? query;

  factory HighlightsConfig.fromJson(Map<String, dynamic> json) =>
      _$HighlightsConfigFromJson(json);
  Map<String, dynamic> toJson() => _$HighlightsConfigToJson(this);
}

/// Summary configuration
@JsonSerializable()
class SummaryConfig {
  const SummaryConfig({this.query, this.schema});

  final String? query;
  final Map<String, dynamic>? schema;

  factory SummaryConfig.fromJson(Map<String, dynamic> json) =>
      _$SummaryConfigFromJson(json);
  Map<String, dynamic> toJson() => _$SummaryConfigToJson(this);
}

/// Extras configuration
@JsonSerializable()
class ExtrasConfig {
  const ExtrasConfig({this.links = 0, this.imageLinks = 0});

  final int links;
  final int imageLinks;

  factory ExtrasConfig.fromJson(Map<String, dynamic> json) =>
      _$ExtrasConfigFromJson(json);
  Map<String, dynamic> toJson() => _$ExtrasConfigToJson(this);
}

/// Context configuration
@JsonSerializable()
class ContextConfig {
  const ContextConfig({this.maxCharacters});

  final int? maxCharacters;

  factory ContextConfig.fromJson(Map<String, dynamic> json) =>
      _$ContextConfigFromJson(json);
  Map<String, dynamic> toJson() => _$ContextConfigToJson(this);
}

/// Contents request configuration
@JsonSerializable()
class ContentsConfig {
  const ContentsConfig({
    this.text,
    this.textConfig,
    this.highlights,
    this.summary,
    this.livecrawl,
    this.livecrawlTimeout = 10000,
    this.subpages = 0,
    this.subpageTarget,
    this.extras,
    this.context,
    this.contextConfig,
  });

  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool? text;
  final TextConfig? textConfig;
  final HighlightsConfig? highlights;
  final SummaryConfig? summary;
  final LivecrawlOption? livecrawl;
  final int livecrawlTimeout;
  final int subpages;
  final dynamic subpageTarget; // String or List<String>
  final ExtrasConfig? extras;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool? context;
  final ContextConfig? contextConfig;

  factory ContentsConfig.fromJson(Map<String, dynamic> json) =>
      _$ContentsConfigFromJson(json);

  Map<String, dynamic> toJson() {
    final json = _$ContentsConfigToJson(this);

    // Handle special text field logic
    if (text != null) {
      if (textConfig != null) {
        json['text'] = textConfig!.toJson();
      } else {
        json['text'] = text;
      }
    }

    // Handle special context field logic
    if (context != null) {
      if (contextConfig != null) {
        json['context'] = contextConfig!.toJson();
      } else {
        json['context'] = context;
      }
    }

    return json;
  }
}

/// Search request parameters
@JsonSerializable()
class SearchRequest {
  const SearchRequest({
    required this.query,
    this.type = SearchType.auto,
    this.category,
    this.numResults = 10,
    this.includeDomains,
    this.excludeDomains,
    this.startCrawlDate,
    this.endCrawlDate,
    this.startPublishedDate,
    this.endPublishedDate,
    this.includeText,
    this.excludeText,
    this.context,
    this.contents,
  });

  final String query;
  final SearchType type;
  @JsonKey(toJson: _categoryToJson)
  final SearchCategory? category;
  final int numResults;
  final List<String>? includeDomains;
  final List<String>? excludeDomains;
  @JsonKey(toJson: _dateTimeToJson)
  final DateTime? startCrawlDate;
  @JsonKey(toJson: _dateTimeToJson)
  final DateTime? endCrawlDate;
  @JsonKey(toJson: _dateTimeToJson)
  final DateTime? startPublishedDate;
  @JsonKey(toJson: _dateTimeToJson)
  final DateTime? endPublishedDate;
  final List<String>? includeText;
  final List<String>? excludeText;
  final bool? context;
  final ContentsConfig? contents;

  static String? _categoryToJson(SearchCategory? category) =>
      category?.apiValue;
  static String? _dateTimeToJson(DateTime? dateTime) =>
      dateTime?.toIso8601String();

  factory SearchRequest.fromJson(Map<String, dynamic> json) =>
      _$SearchRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SearchRequestToJson(this);
}

/// Cost breakdown information
@JsonSerializable()
class CostBreakdown {
  const CostBreakdown({
    required this.search,
    required this.contents,
    required this.breakdown,
  });

  final double search;
  final double contents;
  final Map<String, double> breakdown;

  factory CostBreakdown.fromJson(Map<String, dynamic> json) =>
      _$CostBreakdownFromJson(json);
  Map<String, dynamic> toJson() => _$CostBreakdownToJson(this);
}

/// Cost information
@JsonSerializable()
class CostDollars {
  const CostDollars({
    required this.total,
    required this.breakDown,
    required this.perRequestPrices,
    required this.perPagePrices,
  });

  final double? total;
  final List<CostBreakdown>? breakDown;
  final Map<String, double>? perRequestPrices;
  final Map<String, double>? perPagePrices;

  factory CostDollars.fromJson(Map<String, dynamic> json) =>
      _$CostDollarsFromJson(json);
  Map<String, dynamic> toJson() => _$CostDollarsToJson(this);
}

/// Search result
@JsonSerializable()
class SearchResult {
  const SearchResult({
    required this.title,
    required this.url,
    this.publishedDate,
    this.author,
    this.score,
    required this.id,
    this.image,
    this.favicon,
    this.text,
    this.highlights,
    this.highlightScores,
    this.summary,
    this.subpages,
    this.extras,
  });

  final String title;
  final String url;
  final DateTime? publishedDate;
  final String? author;
  final double? score;
  final String id;
  final String? image;
  final String? favicon;
  final String? text;
  final List<String>? highlights;
  final List<double>? highlightScores;
  final String? summary;
  final List<SearchResult>? subpages;
  final Map<String, dynamic>? extras;

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
}

/// Search response
@JsonSerializable()
class SearchResponse {
  const SearchResponse({
    required this.requestId,
    required this.resolvedSearchType,
    required this.results,
    this.searchType,
    this.context,
    this.costDollars,
  });

  final String requestId;
  final SearchType? resolvedSearchType;
  final List<SearchResult> results;
  final SearchType? searchType;
  final String? context;
  final CostDollars? costDollars;

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}

/// Exception thrown when an API request fails
class ExaApiException implements Exception {
  const ExaApiException(this.message, [this.statusCode]);

  final String message;
  final int? statusCode;

  @override
  String toString() =>
      'ExaApiException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}
