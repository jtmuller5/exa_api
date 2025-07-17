import 'package:test/test.dart';
import 'package:exa_api/exa_api.dart';

void main() {
  group('ExaApi Tests', () {
    late ExaApi exa;

    setUp(() {
      // Note: Replace with your actual API key for testing
      exa = ExaApi(apiKey: 'test_api_key', debugMode: true);
    });

    group('Initialization', () {
      test('should create ExaApi instance with API key', () {
        expect(exa.apiKey, equals('test_api_key'));
        expect(exa.debugMode, isTrue);
      });

      test('should create ExaApi instance with environment variable', () {
        // This would work if EXA_API_KEY is set at compile time
        // For testing, we'll just verify the constructor doesn't throw
        expect(() => ExaApi(apiKey: 'test_key'), returnsNormally);
      });

      test('should throw assertion error with empty API key and no env var', () {
        expect(() => ExaApi(apiKey: ''), throwsA(isA<AssertionError>()));
      });
    });

    group('Search Models', () {
      test('should create SearchRequest with required parameters', () {
        final request = SearchRequest(
          query: 'test query',
          type: SearchType.neural,
          numResults: 10,
        );

        expect(request.query, equals('test query'));
        expect(request.type, equals(SearchType.neural));
        expect(request.numResults, equals(10));
      });

      test('should serialize SearchRequest to JSON', () {
        final request = SearchRequest(
          query: 'test query',
          type: SearchType.auto,
          category: SearchCategory.researchPaper,
          numResults: 5,
          includeDomains: ['arxiv.org'],
          excludeDomains: ['example.com'],
        );

        final json = request.toJson();
        expect(json['query'], equals('test query'));
        expect(json['type'], equals('auto'));
        expect(json['category'], equals('research paper'));
        expect(json['numResults'], equals(5));
        expect(json['includeDomains'], equals(['arxiv.org']));
        expect(json['excludeDomains'], equals(['example.com']));
      });

      test('should create SearchRequest from JSON', () {
        final json = {
          'query': 'test query',
          'type': 'neural',
          'numResults': 10,
        };

        final request = SearchRequest.fromJson(json);
        expect(request.query, equals('test query'));
        expect(request.type, equals(SearchType.neural));
        expect(request.numResults, equals(10));
      });
    });

    group('Search Configuration', () {
      test('should create TextConfig with parameters', () {
        final config = TextConfig(maxCharacters: 1000, includeHtmlTags: true);

        expect(config.maxCharacters, equals(1000));
        expect(config.includeHtmlTags, isTrue);
      });

      test('should create HighlightsConfig with parameters', () {
        final config = HighlightsConfig(
          numSentences: 3,
          highlightsPerUrl: 2,
          query: 'test query',
        );

        expect(config.numSentences, equals(3));
        expect(config.highlightsPerUrl, equals(2));
        expect(config.query, equals('test query'));
      });

      test('should create SummaryConfig with parameters', () {
        final config = SummaryConfig(
          query: 'test query',
          schema: {'type': 'object'},
        );

        expect(config.query, equals('test query'));
        expect(config.schema, equals({'type': 'object'}));
      });

      test('should create ContentsConfig with all parameters', () {
        final config = ContentsConfig(
          text: true,
          textConfig: const TextConfig(maxCharacters: 1000),
          highlights: const HighlightsConfig(numSentences: 2),
          summary: const SummaryConfig(query: 'test'),
          livecrawl: LivecrawlOption.always,
          subpages: 1,
          extras: const ExtrasConfig(links: 5),
        );

        expect(config.text, isTrue);
        expect(config.textConfig?.maxCharacters, equals(1000));
        expect(config.highlights?.numSentences, equals(2));
        expect(config.summary?.query, equals('test'));
        expect(config.livecrawl, equals(LivecrawlOption.always));
        expect(config.subpages, equals(1));
        expect(config.extras?.links, equals(5));
      });
    });

    group('Answer Models', () {
      test('should create AnswerRequest with parameters', () {
        final request = AnswerRequest(
          query: 'test question',
          stream: true,
          text: true,
        );

        expect(request.query, equals('test question'));
        expect(request.stream, isTrue);
        expect(request.text, isTrue);
      });

      test('should create AnswerCitation with parameters', () {
        final citation = AnswerCitation(
          id: 'test-id',
          url: 'https://example.com',
          title: 'Test Article',
          author: 'Test Author',
          publishedDate: '2023-01-01',
          text: 'Test content',
        );

        expect(citation.id, equals('test-id'));
        expect(citation.url, equals('https://example.com'));
        expect(citation.title, equals('Test Article'));
        expect(citation.author, equals('Test Author'));
        expect(citation.publishedDate, equals('2023-01-01'));
        expect(citation.text, equals('Test content'));
      });

      test('should create AnswerCitation with nullable fields', () {
        const citation = AnswerCitation();

        expect(citation.id, isNull);
        expect(citation.url, isNull);
        expect(citation.title, isNull);
        expect(citation.author, isNull);
        expect(citation.publishedDate, isNull);
        expect(citation.text, isNull);
      });
    });

    group('Find Similar Models', () {
      test('should create FindSimilarRequest with parameters', () {
        final request = FindSimilarRequest(
          url: 'https://example.com',
          numResults: 5,
          includeDomains: ['example.com'],
          startPublishedDate: DateTime(2023, 1, 1),
        );

        expect(request.url, equals('https://example.com'));
        expect(request.numResults, equals(5));
        expect(request.includeDomains, equals(['example.com']));
        expect(request.startPublishedDate, equals(DateTime(2023, 1, 1)));
      });

      test(
        'should serialize FindSimilarRequest to JSON with date formatting',
        () {
          final request = FindSimilarRequest(
            url: 'https://example.com',
            numResults: 5,
            startPublishedDate: DateTime(2023, 1, 1),
          );

          final json = request.toJson();
          expect(json['url'], equals('https://example.com'));
          expect(json['numResults'], equals(5));
          expect(json['startPublishedDate'], equals('2023-01-01T00:00:00.000'));
        },
      );
    });

    group('Get Contents Models', () {
      test('should create ContentsRequest with parameters', () {
        final request = ContentsRequest(
          ids: ['https://example.com'],
          text: true,
          highlights: const HighlightsConfig(numSentences: 2),
          livecrawl: LivecrawlOption.fallback,
          subpages: 1,
        );

        expect(request.ids, equals(['https://example.com']));
        expect(request.text, isTrue);
        expect(request.highlights?.numSentences, equals(2));
        expect(request.livecrawl, equals(LivecrawlOption.fallback));
        expect(request.subpages, equals(1));
      });

      test('should create ContentStatus with parameters', () {
        final status = ContentStatus(
          id: 'test-id',
          status: 'success',
          error: {'tag': 'NO_ERROR'},
        );

        expect(status.id, equals('test-id'));
        expect(status.status, equals('success'));
        expect(status.error, equals({'tag': 'NO_ERROR'}));
      });

      test('should create ContentStatus with nullable fields', () {
        const status = ContentStatus();

        expect(status.id, isNull);
        expect(status.status, isNull);
        expect(status.error, isNull);
      });
    });

    group('Answer Response Models', () {
      test('should create AnswerResponse with parameters', () {
        final response = AnswerResponse(
          answer: 'Test answer',
          citations: [
            const AnswerCitation(
              id: 'test-id',
              url: 'https://example.com',
              title: 'Test Title',
            ),
          ],
          costDollars: const CostDollars(
            total: 0.005,
            breakDown: null,
            perRequestPrices: null,
            perPagePrices: null,
          ),
        );

        expect(response.answer, equals('Test answer'));
        expect(response.citations?.length, equals(1));
        expect(response.citations?[0].id, equals('test-id'));
        expect(response.costDollars?.total, equals(0.005));
      });

      test('should create AnswerResponse with nullable fields', () {
        const response = AnswerResponse();

        expect(response.answer, isNull);
        expect(response.citations, isNull);
        expect(response.costDollars, isNull);
      });
    });

    group('Contents Response Models', () {
      test('should create ContentsResponse with parameters', () {
        final response = ContentsResponse(
          requestId: 'test-request-id',
          results: [
            const SearchResult(
              title: 'Test Title',
              url: 'https://example.com',
              id: 'test-id',
            ),
          ],
          context: 'test context',
          statuses: [
            const ContentStatus(
              id: 'test-id',
              status: 'success',
            ),
          ],
        );

        expect(response.requestId, equals('test-request-id'));
        expect(response.results?.length, equals(1));
        expect(response.context, equals('test context'));
        expect(response.statuses?.length, equals(1));
      });

      test('should create ContentsResponse with nullable fields', () {
        const response = ContentsResponse();

        expect(response.requestId, isNull);
        expect(response.results, isNull);
        expect(response.context, isNull);
        expect(response.statuses, isNull);
      });
    });

    group('Search Results', () {
      test('should create SearchResult with parameters', () {
        final result = SearchResult(
          title: 'Test Title',
          url: 'https://example.com',
          id: 'test-id',
          author: 'Test Author',
          score: 0.95,
          publishedDate: DateTime(2023, 1, 1),
          text: 'Test content',
          highlights: ['highlight 1', 'highlight 2'],
          summary: 'Test summary',
        );

        expect(result.title, equals('Test Title'));
        expect(result.url, equals('https://example.com'));
        expect(result.id, equals('test-id'));
        expect(result.author, equals('Test Author'));
        expect(result.score, equals(0.95));
        expect(result.publishedDate, equals(DateTime(2023, 1, 1)));
        expect(result.text, equals('Test content'));
        expect(result.highlights, equals(['highlight 1', 'highlight 2']));
        expect(result.summary, equals('Test summary'));
      });

      test('should create SearchResult with nullable fields', () {
        const result = SearchResult();

        expect(result.title, isNull);
        expect(result.url, isNull);
        expect(result.id, isNull);
        expect(result.author, isNull);
        expect(result.score, isNull);
        expect(result.publishedDate, isNull);
        expect(result.text, isNull);
        expect(result.highlights, isNull);
        expect(result.summary, isNull);
      });

      test('should create SearchResponse with parameters', () {
        final response = SearchResponse(
          requestId: 'test-request-id',
          resolvedSearchType: SearchType.neural,
          results: [
            const SearchResult(
              title: 'Test Title',
              url: 'https://example.com',
              id: 'test-id',
            ),
          ],
          searchType: SearchType.auto,
          context: 'test context',
        );

        expect(response.requestId, equals('test-request-id'));
        expect(response.resolvedSearchType, equals(SearchType.neural));
        expect(response.results?.length, equals(1));
        expect(response.results?[0].title, equals('Test Title'));
        expect(response.searchType, equals(SearchType.auto));
        expect(response.context, equals('test context'));
      });

      test('should create SearchResponse with nullable fields', () {
        const response = SearchResponse();

        expect(response.requestId, isNull);
        expect(response.resolvedSearchType, isNull);
        expect(response.results, isNull);
        expect(response.searchType, isNull);
        expect(response.context, isNull);
      });
    });

    group('Cost Information', () {
      test('should create CostBreakdown with parameters', () {
        final breakdown = CostBreakdown(
          search: 0.005,
          contents: 0.001,
          breakdown: {'neuralSearch': 0.005, 'contentText': 0.001},
        );

        expect(breakdown.search, equals(0.005));
        expect(breakdown.contents, equals(0.001));
        expect(breakdown.breakdown?['neuralSearch'], equals(0.005));
        expect(breakdown.breakdown?['contentText'], equals(0.001));
      });

      test('should create CostBreakdown with nullable fields', () {
        const breakdown = CostBreakdown();

        expect(breakdown.search, isNull);
        expect(breakdown.contents, isNull);
        expect(breakdown.breakdown, isNull);
      });

      test('should create CostDollars with parameters', () {
        final cost = CostDollars(
          total: 0.006,
          breakDown: [
            const CostBreakdown(
              search: 0.005,
              contents: 0.001,
              breakdown: {'neuralSearch': 0.005},
            ),
          ],
          perRequestPrices: {'neuralSearch_1_25_results': 0.005},
          perPagePrices: {'contentText': 0.001},
        );

        expect(cost.total, equals(0.006));
        expect((cost.breakDown ?? []).length, equals(1));
        expect((cost.breakDown ?? [])[0].search, equals(0.005));
        expect(
          cost.perRequestPrices?['neuralSearch_1_25_results'],
          equals(0.005),
        );
        expect(cost.perPagePrices?['contentText'], equals(0.001));
      });
    });

    group('Exception Handling', () {
      test('should create ExaApiException with message', () {
        final exception = ExaApiException('Test error message');
        expect(exception.message, equals('Test error message'));
        expect(exception.statusCode, isNull);
      });

      test('should create ExaApiException with message and status code', () {
        final exception = ExaApiException('Test error message', 400);
        expect(exception.message, equals('Test error message'));
        expect(exception.statusCode, equals(400));
      });

      test('should format ExaApiException toString correctly', () {
        final exception1 = ExaApiException('Test error message');
        expect(
          exception1.toString(),
          equals('ExaApiException: Test error message'),
        );

        final exception2 = ExaApiException('Test error message', 400);
        expect(
          exception2.toString(),
          equals('ExaApiException: Test error message (Status: 400)'),
        );
      });
    });

    group('Enum Values', () {
      test('should have correct SearchType values', () {
        expect(SearchType.keyword.name, equals('keyword'));
        expect(SearchType.neural.name, equals('neural'));
        expect(SearchType.auto.name, equals('auto'));
      });

      test('should have correct SearchCategory values', () {
        expect(SearchCategory.researchPaper.apiValue, equals('research paper'));
        expect(SearchCategory.personalSite.apiValue, equals('personal site'));
        expect(
          SearchCategory.linkedinProfile.apiValue,
          equals('linkedin profile'),
        );
        expect(
          SearchCategory.financialReport.apiValue,
          equals('financial report'),
        );
        expect(SearchCategory.company.apiValue, equals('company'));
        expect(SearchCategory.news.apiValue, equals('news'));
        expect(SearchCategory.pdf.apiValue, equals('pdf'));
        expect(SearchCategory.github.apiValue, equals('github'));
        expect(SearchCategory.tweet.apiValue, equals('tweet'));
      });

      test('should have correct LivecrawlOption values', () {
        expect(LivecrawlOption.never.name, equals('never'));
        expect(LivecrawlOption.fallback.name, equals('fallback'));
        expect(LivecrawlOption.always.name, equals('always'));
        expect(LivecrawlOption.preferred.name, equals('preferred'));
      });
    });
  });
}
