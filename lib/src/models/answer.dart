import 'package:json_annotation/json_annotation.dart';
import 'package:exa_api/src/models/search.dart';

part 'answer.g.dart';

/// Answer request parameters
@JsonSerializable()
class AnswerRequest {
  const AnswerRequest({
    required this.query,
    this.stream = false,
    this.text = false,
  });

  /// The question or query to answer
  final String query;

  /// If true, the response is returned as a server-sent events (SSE) stream
  final bool stream;

  /// If true, the response includes full text content in the search results
  final bool text;

  factory AnswerRequest.fromJson(Map<String, dynamic> json) =>
      _$AnswerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerRequestToJson(this);
}

/// Answer citation from search results
@JsonSerializable()
class AnswerCitation {
  const AnswerCitation({
    required this.id,
    required this.url,
    required this.title,
    this.author,
    this.publishedDate,
    this.text,
    this.image,
    this.favicon,
  });

  /// The temporary ID for the document
  final String id;

  /// The URL of the search result
  final String url;

  /// The title of the search result
  final String title;

  /// If available, the author of the content
  final String? author;

  /// An estimate of the creation date, from parsing HTML content
  final String? publishedDate;

  /// The full text content of each source (only present when text is enabled)
  final String? text;

  /// The URL of the image associated with the search result, if available
  final String? image;

  /// The URL of the favicon for the search result's domain, if available
  final String? favicon;

  factory AnswerCitation.fromJson(Map<String, dynamic> json) =>
      _$AnswerCitationFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerCitationToJson(this);
}

/// Answer response from the API
@JsonSerializable()
class AnswerResponse {
  const AnswerResponse({
    required this.answer,
    required this.citations,
    this.costDollars,
  });

  /// The generated answer based on search results
  final String answer;

  /// Search results used to generate the answer
  final List<AnswerCitation> citations;

  /// Cost information for the request
  final CostDollars? costDollars;

  factory AnswerResponse.fromJson(Map<String, dynamic> json) =>
      _$AnswerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerResponseToJson(this);
}