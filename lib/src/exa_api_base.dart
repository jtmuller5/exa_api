library exa_api;

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:exa_api/src/models/answer.dart';
import 'package:exa_api/src/models/find-similar.dart';
import 'package:exa_api/src/models/get-contents.dart';
import 'package:exa_api/src/models/search.dart';

class ExaApi {
  ExaApi({required this.apiKey, this.debugMode = false})
    : assert(apiKey.isNotEmpty, 'API key must not be empty.');

  final String apiKey;
  final bool debugMode;

  static const String _host = 'https://api.exa.ai';

  /// Performs a search using the Exa API
  ///
  /// [query] - The search query string
  /// [type] - Type of search (neural, keyword, or auto)
  /// [category] - Optional category filter
  /// [numResults] - Number of results to return (default: 10, max: 100)
  /// [includeDomains] - List of domains to include in results
  /// [excludeDomains] - List of domains to exclude from results
  /// [startCrawlDate] - Include results crawled after this date
  /// [endCrawlDate] - Include results crawled before this date
  /// [startPublishedDate] - Include results published after this date
  /// [endPublishedDate] - Include results published before this date
  /// [includeText] - List of strings that must be present in webpage text
  /// [excludeText] - List of strings that must not be present in webpage text
  /// [context] - Whether to format results as context string for LLMs
  /// [contents] - Configuration for content extraction
  ///
  /// Returns a [SearchResponse] containing the search results
  ///
  /// Throws [ExaApiException] if the request fails
  Future<SearchResponse> search({
    required String query,
    SearchType type = SearchType.auto,
    SearchCategory? category,
    int numResults = 10,
    List<String>? includeDomains,
    List<String>? excludeDomains,
    DateTime? startCrawlDate,
    DateTime? endCrawlDate,
    DateTime? startPublishedDate,
    DateTime? endPublishedDate,
    List<String>? includeText,
    List<String>? excludeText,
    bool? context,
    ContentsConfig? contents,
  }) async {
    final request = SearchRequest(
      query: query,
      type: type,
      category: category,
      numResults: numResults,
      includeDomains: includeDomains,
      excludeDomains: excludeDomains,
      startCrawlDate: startCrawlDate,
      endCrawlDate: endCrawlDate,
      startPublishedDate: startPublishedDate,
      endPublishedDate: endPublishedDate,
      includeText: includeText,
      excludeText: excludeText,
      context: context,
      contents: contents,
    );

    return _performSearch(request);
  }

  /// Convenience method for search with content extraction
  ///
  /// This method automatically includes text content and can optionally
  /// include highlights and summaries.
  ///
  /// [query] - The search query string
  /// [type] - Type of search (neural, keyword, or auto)
  /// [category] - Optional category filter
  /// [numResults] - Number of results to return (default: 10, max: 100)
  /// [text] - Whether to include full text content
  /// [highlights] - Configuration for highlights extraction
  /// [summary] - Configuration for summary generation
  /// [maxCharacters] - Maximum characters for text content
  /// [includeHtmlTags] - Whether to include HTML tags in text
  ///
  /// Returns a [SearchResponse] containing the search results with content
  Future<SearchResponse> searchAndContents({
    required String query,
    SearchType type = SearchType.auto,
    SearchCategory? category,
    int numResults = 10,
    bool text = true,
    HighlightsConfig? highlights,
    SummaryConfig? summary,
    int? maxCharacters,
    bool includeHtmlTags = false,
  }) async {
    final textConfig = maxCharacters != null || includeHtmlTags
        ? TextConfig(
            maxCharacters: maxCharacters,
            includeHtmlTags: includeHtmlTags,
          )
        : null;

    final contents = ContentsConfig(
      text: text,
      textConfig: textConfig,
      highlights: highlights,
      summary: summary,
    );

    return search(
      query: query,
      type: type,
      category: category,
      numResults: numResults,
      contents: contents,
    );
  }

  /// Get the full page contents, summaries, and metadata for a list of URLs
  ///
  /// Returns instant results from cache, with automatic live crawling as fallback
  /// for uncached pages.
  ///
  /// [urls] - List of URLs to retrieve content for
  /// [ids] - (Deprecated) Use urls instead. Document IDs obtained from searches
  /// [text] - Whether to include full text content
  /// [textConfig] - Advanced text extraction configuration
  /// [highlights] - Configuration for highlights extraction
  /// [summary] - Configuration for summary generation
  /// [livecrawl] - Livecrawling option (never, fallback, always, preferred)
  /// [livecrawlTimeout] - Timeout for livecrawling in milliseconds
  /// [subpages] - Number of subpages to crawl
  /// [subpageTarget] - Keyword(s) to find specific subpages
  /// [extras] - Configuration for extra content (links, images)
  /// [context] - Whether to format results as context string for LLMs
  /// [contextConfig] - Advanced context configuration
  ///
  /// Returns a [ContentsResponse] containing the page contents and metadata
  ///
  /// Throws [ExaApiException] if the request fails
  Future<ContentsResponse> getContents({
    required List<String> urls,
    List<String>? ids, // Deprecated
    bool? text,
    TextConfig? textConfig,
    HighlightsConfig? highlights,
    SummaryConfig? summary,
    LivecrawlOption? livecrawl,
    int livecrawlTimeout = 10000,
    int subpages = 0,
    dynamic subpageTarget,
    ExtrasConfig? extras,
    bool? context,
    ContextConfig? contextConfig,
  }) async {
    final request = ContentsRequest(
      urls: urls,
      ids: ids,
      text: text,
      textConfig: textConfig,
      highlights: highlights,
      summary: summary,
      livecrawl: livecrawl,
      livecrawlTimeout: livecrawlTimeout,
      subpages: subpages,
      subpageTarget: subpageTarget,
      extras: extras,
      context: context,
      contextConfig: contextConfig,
    );

    return _performContentsRequest(request);
  }

  /// Convenience method for getting contents with common options
  ///
  /// This method provides a simplified interface for the most common use cases
  /// of content retrieval.
  ///
  /// [urls] - List of URLs to retrieve content for
  /// [text] - Whether to include full text content
  /// [highlights] - Configuration for highlights extraction
  /// [summary] - Configuration for summary generation
  /// [maxCharacters] - Maximum characters for text content
  /// [includeHtmlTags] - Whether to include HTML tags in text
  /// [livecrawl] - Livecrawling option
  /// [subpages] - Number of subpages to crawl
  ///
  /// Returns a [ContentsResponse] containing the page contents
  Future<ContentsResponse> getContentsSimple({
    required List<String> urls,
    bool text = true,
    HighlightsConfig? highlights,
    SummaryConfig? summary,
    int? maxCharacters,
    bool includeHtmlTags = false,
    LivecrawlOption livecrawl = LivecrawlOption.fallback,
    int subpages = 0,
  }) async {
    final textConfig = maxCharacters != null || includeHtmlTags
        ? TextConfig(
            maxCharacters: maxCharacters,
            includeHtmlTags: includeHtmlTags,
          )
        : null;

    return getContents(
      urls: urls,
      text: text,
      textConfig: textConfig,
      highlights: highlights,
      summary: summary,
      livecrawl: livecrawl,
      subpages: subpages,
    );
  }

  /// Get an LLM answer to a question informed by Exa search results
  ///
  /// The `/answer` endpoint performs an Exa search and uses an LLM to generate either:
  /// 1. A direct answer for specific queries (e.g., "What is the capital of France?" returns "Paris")
  /// 2. A detailed summary with citations for open-ended queries (e.g., "What is the state of AI in healthcare?")
  ///
  /// The response includes both the generated answer and the sources used to create it.
  ///
  /// [query] - The question or query to answer
  /// [stream] - If true, the response is returned as a server-sent events (SSE) stream
  /// [text] - If true, the response includes full text content in the search results
  ///
  /// Returns an [AnswerResponse] containing the generated answer and citations
  ///
  /// Throws [ExaApiException] if the request fails
  Future<AnswerResponse> answer({
    required String query,
    bool stream = false,
    bool text = false,
  }) async {
    final request = AnswerRequest(
      query: query,
      stream: stream,
      text: text,
    );

    return _performAnswerRequest(request);
  }

  Future<AnswerResponse> _performAnswerRequest(AnswerRequest request) async {
    final client = HttpClient();

    try {
      final uri = Uri.parse('$_host/answer');
      final httpRequest = await client.postUrl(uri);

      // Set headers
      httpRequest.headers.set('Content-Type', 'application/json');
      httpRequest.headers.set('x-api-key', apiKey);

      if (debugMode) {
        httpRequest.headers.set('User-Agent', 'exa_api_dart/1.0.0 (debug)');
      }

      // Set body
      final bodyJson = jsonEncode(request.toJson());
      httpRequest.write(bodyJson);

      if (debugMode) {
        print('Exa API Request: POST $uri');
        print('Request body: $bodyJson');
      }

      final response = await httpRequest.close();
      final responseBody = await response.transform(utf8.decoder).join();

      if (debugMode) {
        print('Response status: ${response.statusCode}');
        print('Response body: $responseBody');
      }

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(responseBody) as Map<String, dynamic>;
        return AnswerResponse.fromJson(jsonResponse);
      } else {
        String errorMessage =
            'Request failed with status ${response.statusCode}';

        try {
          final errorJson = jsonDecode(responseBody) as Map<String, dynamic>;
          errorMessage = errorJson['message'] ?? errorMessage;
        } catch (_) {
          // If we can't parse the error response, use the default message
        }

        throw ExaApiException(errorMessage, response.statusCode);
      }
    } catch (e) {
      if (e is ExaApiException) {
        rethrow;
      }
      throw ExaApiException('Network error: $e');
    } finally {
      client.close();
    }
  }

  Future<SearchResponse> _performSearch(SearchRequest request) async {
    final client = HttpClient();

    try {
      final uri = Uri.parse('$_host/search');
      final httpRequest = await client.postUrl(uri);

      // Set headers
      httpRequest.headers.set('Content-Type', 'application/json');
      httpRequest.headers.set('x-api-key', apiKey);

      if (debugMode) {
        httpRequest.headers.set('User-Agent', 'exa_api_dart/1.0.0 (debug)');
      }

      // Set body
      final bodyJson = jsonEncode(request.toJson());
      httpRequest.write(bodyJson);

      if (debugMode) {
        print('Exa API Request: POST $uri');
        print('Request body: $bodyJson');
      }

      final response = await httpRequest.close();
      final responseBody = await response.transform(utf8.decoder).join();

      if (debugMode) {
        print('Response status: ${response.statusCode}');
        print('Response body: $responseBody');
      }

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(responseBody) as Map<String, dynamic>;
        log("Search response: $jsonResponse");
        return SearchResponse.fromJson(jsonResponse);
      } else {
        String errorMessage =
            'Request failed with status ${response.statusCode}';

        try {
          final errorJson = jsonDecode(responseBody) as Map<String, dynamic>;
          errorMessage = errorJson['message'] ?? errorMessage;
        } catch (_) {
          // If we can't parse the error response, use the default message
        }

        throw ExaApiException(errorMessage, response.statusCode);
      }
    } catch (e) {
      if (e is ExaApiException) {
        print('Exa API Error: ${e.message}');
        rethrow;
      }
      throw ExaApiException('Network error: $e');
    } finally {
      client.close();
    }
  }

  Future<ContentsResponse> _performContentsRequest(
    ContentsRequest request,
  ) async {
    final client = HttpClient();

    try {
      final uri = Uri.parse('$_host/contents');
      final httpRequest = await client.postUrl(uri);

      // Set headers
      httpRequest.headers.set('Content-Type', 'application/json');
      httpRequest.headers.set('x-api-key', apiKey);

      if (debugMode) {
        httpRequest.headers.set('User-Agent', 'exa_api_dart/1.0.0 (debug)');
      }

      // Set body
      final bodyJson = jsonEncode(request.toJson());
      httpRequest.write(bodyJson);

      if (debugMode) {
        print('Exa API Request: POST $uri');
        print('Request body: $bodyJson');
      }

      final response = await httpRequest.close();
      final responseBody = await response.transform(utf8.decoder).join();

      if (debugMode) {
        print('Response status: ${response.statusCode}');
        print('Response body: $responseBody');
      }

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(responseBody) as Map<String, dynamic>;
        return ContentsResponse.fromJson(jsonResponse);
      } else {
        String errorMessage =
            'Request failed with status ${response.statusCode}';

        try {
          final errorJson = jsonDecode(responseBody) as Map<String, dynamic>;
          errorMessage = errorJson['message'] ?? errorMessage;
        } catch (_) {
          // If we can't parse the error response, use the default message
        }

        throw ExaApiException(errorMessage, response.statusCode);
      }
    } catch (e) {
      if (e is ExaApiException) {
        rethrow;
      }
      throw ExaApiException('Network error: $e');
    } finally {
      client.close();
    }
  }

  /// Find similar links to the provided URL
  ///
  /// Find similar links to the link provided and optionally return the contents of the pages.
  ///
  /// [url] - The url for which you would like to find similar links
  /// [numResults] - Number of results to return (default: 10, max: 100)
  /// [includeDomains] - List of domains to include in results
  /// [excludeDomains] - List of domains to exclude from results
  /// [startCrawlDate] - Include results crawled after this date
  /// [endCrawlDate] - Include results crawled before this date
  /// [startPublishedDate] - Include results published after this date
  /// [endPublishedDate] - Include results published before this date
  /// [includeText] - List of strings that must be present in webpage text
  /// [excludeText] - List of strings that must not be present in webpage text
  /// [context] - Whether to format results as context string for LLMs
  /// [contents] - Configuration for content extraction
  ///
  /// Returns a [FindSimilarResponse] containing the similar links
  ///
  /// Throws [ExaApiException] if the request fails
  Future<FindSimilarResponse> findSimilar({
    required String url,
    int numResults = 10,
    List<String>? includeDomains,
    List<String>? excludeDomains,
    DateTime? startCrawlDate,
    DateTime? endCrawlDate,
    DateTime? startPublishedDate,
    DateTime? endPublishedDate,
    List<String>? includeText,
    List<String>? excludeText,
    bool? context,
    ContentsConfig? contents,
  }) async {
    final request = FindSimilarRequest(
      url: url,
      numResults: numResults,
      includeDomains: includeDomains,
      excludeDomains: excludeDomains,
      startCrawlDate: startCrawlDate,
      endCrawlDate: endCrawlDate,
      startPublishedDate: startPublishedDate,
      endPublishedDate: endPublishedDate,
      includeText: includeText,
      excludeText: excludeText,
      context: context,
      contents: contents,
    );

    return _performFindSimilar(request);
  }

  Future<FindSimilarResponse> _performFindSimilar(FindSimilarRequest request) async {
    final client = HttpClient();

    try {
      final uri = Uri.parse('$_host/find-similar');
      final httpRequest = await client.postUrl(uri);

      // Set headers
      httpRequest.headers.set('Content-Type', 'application/json');
      httpRequest.headers.set('x-api-key', apiKey);

      if (debugMode) {
        httpRequest.headers.set('User-Agent', 'exa_api_dart/1.0.0 (debug)');
      }

      // Set body
      final bodyJson = jsonEncode(request.toJson());
      httpRequest.write(bodyJson);

      if (debugMode) {
        print('Exa API Request: POST $uri');
        print('Request body: $bodyJson');
      }

      final response = await httpRequest.close();
      final responseBody = await response.transform(utf8.decoder).join();

      if (debugMode) {
        print('Response status: ${response.statusCode}');
        print('Response body: $responseBody');
      }

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(responseBody) as Map<String, dynamic>;
        return FindSimilarResponse.fromJson(jsonResponse);
      } else {
        String errorMessage =
            'Request failed with status ${response.statusCode}';

        try {
          final errorJson = jsonDecode(responseBody) as Map<String, dynamic>;
          errorMessage = errorJson['message'] ?? errorMessage;
        } catch (_) {
          // If we can't parse the error response, use the default message
        }

        throw ExaApiException(errorMessage, response.statusCode);
      }
    } catch (e) {
      if (e is ExaApiException) {
        rethrow;
      }
      throw ExaApiException('Network error: $e');
    } finally {
      client.close();
    }
  }
}
