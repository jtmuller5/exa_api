import 'package:exa_api/exa_api.dart';
import 'package:exa_api/src/exa_api_base.dart';
import 'package:exa_api/src/models/search.dart';

void main() async {
  // Initialize the Exa API client
  final exa = ExaApi(
    apiKey: 'YOUR_EXA_API_KEY',
    debugMode: true, // Enable debug mode to see request/response details
  );

  try {
    // Simple search
    print('=== Simple Search ===');
    final simpleResults = await exa.search(
      query: 'Latest developments in LLM capabilities',
      numResults: 5,
    );

    print('Found ${simpleResults.results.length} results');
    for (final result in simpleResults.results) {
      print('- ${result.title}');
      print('  URL: ${result.url}');
      print('  Score: ${result.score}');
    }

    // Search with content extraction
    print('\n=== Search with Content ===');
    final contentResults = await exa.searchAndContents(
      query: 'Latest research in LLMs',
      category: SearchCategory.researchPaper,
      numResults: 3,
      text: true,
      highlights: const HighlightsConfig(
        numSentences: 2,
        highlightsPerUrl: 2,
        query: 'Key advancements',
      ),
      summary: const SummaryConfig(query: 'Main developments'),
      maxCharacters: 1000,
    );

    for (final result in contentResults.results) {
      print('Title: ${result.title}');
      print('Author: ${result.author ?? 'Unknown'}');
      if (result.text != null) {
        print('Text excerpt: ${result.text!.substring(0, 200)}...');
      }
      if (result.highlights != null) {
        print('Highlights: ${result.highlights!.join(' | ')}');
      }
      if (result.summary != null) {
        print('Summary: ${result.summary}');
      }
      print('---');
    }

    // Advanced search with filters
    print('\n=== Advanced Search with Filters ===');
    final advancedResults = await exa.search(
      query: 'machine learning research',
      type: SearchType.neural,
      category: SearchCategory.researchPaper,
      numResults: 5,
      includeDomains: ['arxiv.org', 'paperswithcode.com'],
      startPublishedDate: DateTime(2023, 1, 1),
      endPublishedDate: DateTime(2023, 12, 31),
      includeText: ['large language model'],
      excludeText: ['course'],
      contents: const ContentsConfig(
        text: true,
        highlights: HighlightsConfig(numSentences: 1, highlightsPerUrl: 1),
        extras: ExtrasConfig(links: 1, imageLinks: 1),
      ),
    );

    print('Advanced search found ${advancedResults.results.length} results');
    if (advancedResults.costDollars != null) {
      print('Cost: \$${advancedResults.costDollars!.total}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
