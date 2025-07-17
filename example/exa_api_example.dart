import 'package:exa_api/exa_api.dart';

/// Comprehensive example demonstrating all Exa API features
///
/// This example shows how to:
/// - Search the web with neural and keyword search
/// - Get AI-powered answers with citations
/// - Extract content from URLs
/// - Find similar pages
/// - Handle errors and costs
///
/// ## API Key Setup
///
/// Set your API key as an environment variable at compile time:
/// ```bash
/// # Option 1: Using dart run with --define
/// dart run --define=EXA_API_KEY=your_api_key_here exa_api_example.dart
///
/// # Option 2: Using system environment variable
/// export EXA_API_KEY="your_api_key_here"
/// dart run exa_api_example.dart
/// ```
///
/// Or pass it explicitly to the constructor (not recommended for production)
Future<void> main() async {
  // Initialize the Exa API client
  // Option 1: Use environment variable (recommended)
  // Set EXA_API_KEY environment variable before running
  final exa = ExaApi(debugMode: true);
  
  // Option 2: Explicit API key (not recommended for production)
  // final exa = ExaApi(apiKey: 'your_api_key_here', debugMode: true);

  print('🚀 Exa API Dart SDK Example');
  print('=' * 50);

  // Example 1: Basic Search
  await _demonstrateSearch(exa);

  // Example 2: Advanced Search with Content
  await _demonstrateAdvancedSearch(exa);

  // Example 3: AI-Powered Answers
  await _demonstrateAnswer(exa);

  // Example 4: Get Contents from URLs
  await _demonstrateGetContents(exa);

  // Example 5: Find Similar Pages
  await _demonstrateFindSimilar(exa);

  // Example 6: Error Handling
  await _demonstrateErrorHandling(exa);

  // Example 7: Advanced Configurations
  await _demonstrateAdvancedConfigurations(exa);

  // Example 8: Cost Monitoring
  await _demonstrateCostMonitoring(exa);

  print('✅ All examples completed!');
}

/// Demonstrate basic search functionality
Future<void> _demonstrateSearch(ExaApi exa) async {
  print('\n1️⃣ Basic Search Example');
  print('-' * 30);

  try {
    final results = await exa.search(
      query: 'machine learning research 2024',
      type: SearchType.neural,
      numResults: 3,
      category: SearchCategory.researchPaper,
    );

    print('Search type used: ${results.resolvedSearchType?.name ?? 'Unknown'}');
    print('Found ${results.results?.length ?? 0} results');

    if (results.costDollars != null) {
      print('Cost: \$${(results.costDollars!.total ?? 0).toStringAsFixed(4)}');
    }

    final resultsList = results.results ?? [];
    for (int i = 0; i < resultsList.length; i++) {
      final result = resultsList[i];
      print('${i + 1}. ${result.title ?? 'No title'}');
      print('   URL: ${result.url ?? 'No URL'}');
      print('   Score: ${result.score?.toStringAsFixed(3) ?? 'N/A'}');
      print('   Author: ${result.author ?? 'Unknown'}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

/// Demonstrate advanced search with content extraction
Future<void> _demonstrateAdvancedSearch(ExaApi exa) async {
  print('\n2️⃣ Advanced Search with Content');
  print('-' * 35);

  try {
    final results = await exa.searchAndContents(
      query: 'quantum computing breakthroughs',
      type: SearchType.auto,
      numResults: 2,
      text: true,
      highlights: const HighlightsConfig(
        numSentences: 2,
        highlightsPerUrl: 1,
        query: 'key findings',
      ),
      summary: const SummaryConfig(query: 'What are the main discoveries?'),
      maxCharacters: 1000,
    );

    print('Search Results with Content:');

    final resultsList = results.results ?? [];
    for (int i = 0; i < resultsList.length; i++) {
      final result = resultsList[i];
      print('\n${i + 1}. ${result.title ?? 'No title'}');
      print('   URL: ${result.url ?? 'No URL'}');

      if (result.summary != null && result.summary!.isNotEmpty) {
        print('   Summary: ${result.summary}');
      }

      if (result.highlights != null && result.highlights!.isNotEmpty) {
        print('   Highlights: ${result.highlights!.join(' | ')}');
      }

      if (result.text != null && result.text!.isNotEmpty) {
        final text = result.text!.length > 200
            ? '${result.text!.substring(0, 200)}...'
            : result.text!;
        print('   Content: $text');
      }
    }
  } catch (e) {
    print('Error: $e');
  }
}

/// Demonstrate AI-powered answers
Future<void> _demonstrateAnswer(ExaApi exa) async {
  print('\n3️⃣ AI-Powered Answer Example');
  print('-' * 30);

  try {
    final answer = await exa.answer(
      query: 'What are the latest developments in large language models?',
      text: true,
    );

    print(
      'Question: What are the latest developments in large language models?',
    );
    print('Answer: ${answer.answer ?? 'No answer provided'}');
    
    final citationsList = answer.citations ?? [];
    print('\nSources used (${citationsList.length}):');

    for (int i = 0; i < citationsList.length; i++) {
      final citation = citationsList[i];
      print('${i + 1}. ${citation.title ?? 'No title'}');
      print('   URL: ${citation.url ?? 'No URL'}');
      print('   Author: ${citation.author ?? 'Unknown'}');

      if (citation.text != null && citation.text!.isNotEmpty) {
        final text = citation.text!.length > 150
            ? '${citation.text!.substring(0, 150)}...'
            : citation.text!;
        print('   Content: $text');
      }
    }
  } catch (e) {
    print('Error: $e');
  }
}

/// Demonstrate content extraction from URLs
Future<void> _demonstrateGetContents(ExaApi exa) async {
  print('\n4️⃣ Get Contents Example');
  print('-' * 25);

  try {
    final contents = await exa.getContentsSimple(
      ids: [
        'https://arxiv.org/abs/2307.06435',
        'https://openai.com/research/gpt-4',
      ],
      text: true,
      highlights: const HighlightsConfig(
        numSentences: 3,
        highlightsPerUrl: 2,
        query: 'methodology and results',
      ),
      summary: const SummaryConfig(query: 'What are the key contributions?'),
      maxCharacters: 1500,
    );

    print('Extracted content from ${contents.results?.length ?? 0} URLs:');

    final resultsList = contents.results ?? [];
    for (int i = 0; i < resultsList.length; i++) {
      final result = resultsList[i];
      print('\n${i + 1}. ${result.title ?? 'No title'}');
      print('   URL: ${result.url ?? 'No URL'}');
      print('   Author: ${result.author ?? 'Unknown'}');
      print('   Published: ${result.publishedDate?.toString() ?? 'Unknown'}');

      if (result.summary != null && result.summary!.isNotEmpty) {
        print('   Summary: ${result.summary}');
      }

      if (result.highlights != null && result.highlights!.isNotEmpty) {
        print('   Highlights:');
        for (int j = 0; j < result.highlights!.length; j++) {
          print('     ${j + 1}. ${result.highlights![j]}');
        }
      }

      if (result.text != null && result.text!.isNotEmpty) {
        final text = result.text!.length > 300
            ? '${result.text!.substring(0, 300)}...'
            : result.text!;
        print('   Content: $text');
      }
    }
  } catch (e) {
    print('Error: $e');
  }
}

/// Demonstrate finding similar pages
Future<void> _demonstrateFindSimilar(ExaApi exa) async {
  print('\n5️⃣ Find Similar Pages Example');
  print('-' * 32);

  try {
    final similar = await exa.findSimilar(
      url: 'https://arxiv.org/abs/2307.06435',
      numResults: 3,
      includeDomains: ['arxiv.org', 'openreview.net'],
      contents: const ContentsConfig(
        text: true,
        highlights: HighlightsConfig(numSentences: 2, highlightsPerUrl: 1),
        summary: SummaryConfig(query: 'Main topic and contributions'),
      ),
    );

    print('Similar pages to: https://arxiv.org/abs/2307.06435');
    print('Found ${similar.results?.length ?? 0} similar pages:');

    final resultsList = similar.results ?? [];
    for (int i = 0; i < resultsList.length; i++) {
      final result = resultsList[i];
      print('\n${i + 1}. ${result.title ?? 'No title'}');
      print('   URL: ${result.url ?? 'No URL'}');
      print(
        '   Similarity Score: ${result.score?.toStringAsFixed(3) ?? 'N/A'}',
      );
      print('   Author: ${result.author ?? 'Unknown'}');

      if (result.summary != null && result.summary!.isNotEmpty) {
        print('   Summary: ${result.summary}');
      }

      if (result.highlights != null && result.highlights!.isNotEmpty) {
        print('   Highlights: ${result.highlights!.join(' | ')}');
      }

      if (result.text != null && result.text!.isNotEmpty) {
        final text = result.text!.length > 200
            ? '${result.text!.substring(0, 200)}...'
            : result.text!;
        print('   Content: $text');
      }
    }
  } catch (e) {
    print('Error: $e');
  }
}

/// Demonstrate error handling
Future<void> _demonstrateErrorHandling(ExaApi exa) async {
  print('\n6️⃣ Error Handling Example');
  print('-' * 28);

  // Example 1: Invalid API key
  try {
    final invalidExa = ExaApi(apiKey: 'invalid_key');
    await invalidExa.search(query: 'test');
  } on ExaApiException catch (e) {
    print('Caught ExaApiException: ${e.message}');
    if (e.statusCode != null) {
      print('Status Code: ${e.statusCode}');
    }
  } catch (e) {
    print('Caught general exception: $e');
  }

  // Example 2: Missing API key (both parameter and environment variable)
  try {
    // This would throw an assertion error if EXA_API_KEY env var is not set
    // and no apiKey parameter is provided
    print('Note: If EXA_API_KEY environment variable is not set, creating');
    print('ExaApi() without an apiKey parameter would throw an assertion error.');
  } catch (e) {
    print('Missing API key error: $e');
  }

  // Example 3: Empty query
  try {
    await exa.search(query: '');
  } on ExaApiException catch (e) {
    print('Empty query error: ${e.message}');
  } catch (e) {
    print('Unexpected error: $e');
  }

  // Example 4: Network error simulation
  print(
    'Network and API errors are handled gracefully with detailed messages.',
  );
}

/// Demonstrate advanced search configurations
Future<void> _demonstrateAdvancedConfigurations(ExaApi exa) async {
  print('\n7️⃣ Advanced Configuration Examples');
  print('-' * 38);

  // Example 1: Date-filtered search
  try {
    final results = await exa.search(
      query: 'AI research papers',
      type: SearchType.neural,
      category: SearchCategory.researchPaper,
      numResults: 5,
      startPublishedDate: DateTime(2023, 1, 1),
      endPublishedDate: DateTime(2023, 12, 31),
      includeDomains: ['arxiv.org', 'openreview.net'],
      includeText: ['transformer', 'attention'],
      excludeText: ['survey'],
    );

    print('Date-filtered search results:');
    final resultsList = results.results ?? [];
    for (final result in resultsList) {
      print(
        '- ${result.title ?? 'No title'} (${result.publishedDate?.toString() ?? 'Unknown date'})',
      );
    }
  } catch (e) {
    print('Error in date-filtered search: $e');
  }

  // Example 2: Advanced content extraction
  try {
    final contents = await exa.getContents(
      ids: ['https://arxiv.org/abs/2307.06435'],
      text: true,
      textConfig: const TextConfig(maxCharacters: 2000, includeHtmlTags: false),
      highlights: const HighlightsConfig(
        numSentences: 3,
        highlightsPerUrl: 2,
        query: 'methodology and results',
      ),
      summary: const SummaryConfig(
        query: 'What are the key contributions and methodology?',
      ),
      livecrawl: LivecrawlOption.preferred,
      subpages: 1,
      extras: const ExtrasConfig(links: 5, imageLinks: 3),
    );

    print('\nAdvanced content extraction:');
    final resultsList = contents.results ?? [];
    for (final result in resultsList) {
      print('Title: ${result.title ?? 'No title'}');
      if (result.extras != null) {
        print('Extra links found: ${result.extras!['links']?.length ?? 0}');
      }
    }
  } catch (e) {
    print('Error in advanced content extraction: $e');
  }
}

/// Demonstrate cost monitoring
Future<void> _demonstrateCostMonitoring(ExaApi exa) async {
  print('\n8️⃣ Cost Monitoring Example');
  print('-' * 28);

  try {
    final results = await exa.searchAndContents(
      query: 'machine learning',
      numResults: 5,
      text: true,
      highlights: const HighlightsConfig(numSentences: 2),
      summary: const SummaryConfig(),
    );

    if (results.costDollars != null) {
      final cost = results.costDollars!;
      print('💰 Cost Breakdown:');
      print('Total Cost: \$${cost.total?.toStringAsFixed(6)}');

      if (cost.breakDown != null) {
        for (final breakdown in cost.breakDown!) {
          print('Search Cost: \$${(breakdown.search ?? 0).toStringAsFixed(6)}');
          print('Content Cost: \$${(breakdown.contents ?? 0).toStringAsFixed(6)}');

          print('Detailed Breakdown:');
          breakdown.breakdown?.forEach((key, value) {
            print('  $key: \$${value.toStringAsFixed(6)}');
          });
        }
      }

      print('\nPricing Information:');
      print('Per Request Prices:');
      cost.perRequestPrices?.forEach((key, value) {
        print('  $key: \$${value.toStringAsFixed(6)}');
      });

      print('Per Page Prices:');
      cost.perPagePrices?.forEach((key, value) {
        print('  $key: \$${value.toStringAsFixed(6)}');
      });
    }
  } catch (e) {
    print('Error in cost monitoring: $e');
  }
}
