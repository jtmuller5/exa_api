import 'package:json_annotation/json_annotation.dart';
import 'package:exa_api/exa_api.dart';

part 'get-contents.g.dart';

/// Contents request parameters
@JsonSerializable()
class ContentsRequest {
  ContentsRequest({
    //required this.urls,
    required this.ids,
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

  //List<String>? urls;
  List<String>? ids; // Deprecated but kept for backwards compatibility
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

  factory ContentsRequest.fromJson(Map<String, dynamic> json) =>
      _$ContentsRequestFromJson(json);

  Map<String, dynamic> toJson() {
    final json = _$ContentsRequestToJson(this);

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

/// Status information for each requested URL
@JsonSerializable()
class ContentStatus {
  const ContentStatus({required this.id, required this.status, this.error});

  final String id;
  final String status;
  final Map<String, dynamic>? error;

  factory ContentStatus.fromJson(Map<String, dynamic> json) =>
      _$ContentStatusFromJson(json);
  Map<String, dynamic> toJson() => _$ContentStatusToJson(this);
}

/// Contents response
@JsonSerializable()
class ContentsResponse {
  const ContentsResponse({
    required this.requestId,
    required this.results,
    this.context,
    this.statuses,
    this.costDollars,
  });

  final String requestId;
  final List<SearchResult> results;
  final String? context;
  final List<ContentStatus>? statuses;
  final CostDollars? costDollars;

  factory ContentsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContentsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ContentsResponseToJson(this);
}
