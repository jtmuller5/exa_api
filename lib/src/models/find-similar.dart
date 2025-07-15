import 'package:json_annotation/json_annotation.dart';
import 'package:exa_api/src/models/search.dart';

part 'find-similar.g.dart';

/// Find similar request parameters
@JsonSerializable()
class FindSimilarRequest {
  const FindSimilarRequest({
    required this.url,
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

  /// The url for which you would like to find similar links
  final String url;

  /// Number of results to return (up to thousands of results available for custom plans)
  final int numResults;

  /// List of domains to include in the search. If specified, results will only come from these domains.
  final List<String>? includeDomains;

  /// List of domains to exclude from search results. If specified, no results will be returned from these domains.
  final List<String>? excludeDomains;

  /// Crawl date refers to the date that Exa discovered a link. Results will include links that were crawled after this date.
  @JsonKey(toJson: _dateTimeToJson)
  final DateTime? startCrawlDate;

  /// Crawl date refers to the date that Exa discovered a link. Results will include links that were crawled before this date.
  @JsonKey(toJson: _dateTimeToJson)
  final DateTime? endCrawlDate;

  /// Only links with a published date after this will be returned.
  @JsonKey(toJson: _dateTimeToJson)
  final DateTime? startPublishedDate;

  /// Only links with a published date before this will be returned.
  @JsonKey(toJson: _dateTimeToJson)
  final DateTime? endPublishedDate;

  /// List of strings that must be present in webpage text of results. Currently, only 1 string is supported, of up to 5 words.
  final List<String>? includeText;

  /// List of strings that must not be present in webpage text of results. Currently, only 1 string is supported, of up to 5 words.
  final List<String>? excludeText;

  /// Whether to format results as context string for LLMs
  final bool? context;

  /// Configuration for content extraction
  final ContentsConfig? contents;

  static String? _dateTimeToJson(DateTime? dateTime) =>
      dateTime?.toIso8601String();

  factory FindSimilarRequest.fromJson(Map<String, dynamic> json) =>
      _$FindSimilarRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FindSimilarRequestToJson(this);
}

/// Find similar response (reuses SearchResponse structure since response format is identical)
typedef FindSimilarResponse = SearchResponse;