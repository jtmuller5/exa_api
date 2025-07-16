![Exa AI](https://github.com/jtmuller5/exa_api/raw/main/assets/exa.jpeg)

<p align="center">                    
<a href="https://img.shields.io/badge/License-MIT-green"><img src="https://img.shields.io/badge/License-MIT-green" alt="MIT License"></a>
<a href="https://pub.dev/publishers/joemuller.com/packages"><img src="https://img.shields.io/pub/v/exa_api?label=pub&color=blue" alt="pub version"></a>      
<a href="https://twitter.com/BosonJoe">
    <img src="https://img.shields.io/twitter/follow/BosonJoe?style=social">
  </a>
</p>


<p align="center">
  <a href="https://joemuller.com">Developer Blog</a> •
    <a href="https://sapiblabs.com">Sapid Labs</a> •
  <a href="https://github.com/jtmuller5/exa_api/">GitHub Repo</a> •
  <a href="https://pub.dev/packages/exa_api/install">Pub.dev</a>
</p>

---

# Exa API Dart SDK

A pure Dart SDK for the Exa API. Search the web with neural and keyword search, get content from any URL, find similar links, and get AI-powered answers.

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  exa_api: ^1.0.0
```

## Setup

1. Get your API key from [Exa Dashboard](https://dashboard.exa.ai/api-keys)
2. Initialize the client:

```dart
import 'package:exa_api/exa_api.dart';

final exa = ExaApi(
  apiKey: 'YOUR_EXA_API_KEY',
  debugMode: true, // Optional: enable debug logging
);
```

## API Methods

### 1. Search

Perform semantic or keyword searches across the web.

```dart
// Basic search
final results = await exa.search(
  query: 'Latest developments in machine learning',
  numResults: 10,
);

// Advanced search with filters
final advancedResults = await exa.search(
  query: 'machine learning research papers',
  type: SearchType.neural,
  category: SearchCategory.researchPaper,
  numResults: 5,
  includeDomains: ['arxiv.org', 'paperswithcode.com'],
  startPublishedDate: DateTime(2023, 1, 1),
  endPublishedDate: DateTime(2023, 12, 31),
  includeText: ['large language model'],
  excludeText: ['survey'],
  contents: const ContentsConfig(
    text: true,
    highlights: HighlightsConfig(
      numSentences: 2,
      highlightsPerUrl: 1,
    ),
  ),
);

print('Found ${advancedResults.results.length} results');
for (final result in advancedResults.results) {
  print('${result.title}: ${result.url}');
}
```

### 2. Search and Contents

Convenience method that combines search with content extraction.

```dart
final contentResults = await exa.searchAndContents(
  query: 'AI safety research',
  type: SearchType.neural,
  category: SearchCategory.researchPaper,
  numResults: 3,
  text: true,
  highlights: const HighlightsConfig(
    numSentences: 2,
    highlightsPerUrl: 2,
    query: 'Key findings',
  ),
  summary: const SummaryConfig(query: 'Main conclusions'),
  maxCharacters: 1000,
);

for (final result in contentResults.results) {
  print('Title: ${result.title}');
  print('Author: ${result.author ?? 'Unknown'}');
  if (result.text != null) {
    print('Text: ${result.text!.substring(0, 200)}...');
  }
  if (result.highlights != null) {
    print('Highlights: ${result.highlights!.join(' | ')}');
  }
  if (result.summary != null) {
    print('Summary: ${result.summary}');
  }
}
```

### 3. Get Contents

Extract content, summaries, and metadata from specific URLs.

```dart
final contents = await exa.getContents(
  urls: [
    'https://arxiv.org/abs/2301.00001',
    'https://paperswithcode.com/paper/example',
  ],
  text: true,
  textConfig: const TextConfig(
    maxCharacters: 2000,
    includeHtmlTags: false,
  ),
  highlights: const HighlightsConfig(
    numSentences: 3,
    highlightsPerUrl: 2,
    query: 'methodology',
  ),
  summary: const SummaryConfig(
    query: 'What are the main contributions?',
  ),
  livecrawl: LivecrawlOption.fallback,
  subpages: 2,
  extras: const ExtrasConfig(
    links: 5,
    imageLinks: 3,
  ),
);

for (final content in contents.results) {
  print('URL: ${content.url}');
  print('Title: ${content.title}');
  if (content.text != null) {
    print('Content: ${content.text!.substring(0, 300)}...');
  }
  if (content.summary != null) {
    print('Summary: ${content.summary}');
  }
  if (content.extras?.links != null) {
    print('Links found: ${content.extras!.links!.length}');
  }
}
```

### 4. Get Contents Simple

Simplified content extraction with common options.

```dart
final simpleContents = await exa.getContentsSimple(
  urls: ['https://example.com/article'],
  text: true,
  highlights: const HighlightsConfig(numSentences: 2),
  summary: const SummaryConfig(),
  maxCharacters: 1500,
  includeHtmlTags: false,
  livecrawl: LivecrawlOption.preferred,
  subpages: 1,
);

final result = simpleContents.results.first;
print('Title: ${result.title}');
print('Content: ${result.text ?? 'No content available'}');
```

### 5. Answer

Get AI-powered answers to questions informed by Exa search results.

```dart
final answer = await exa.answer(
  query: 'What are the latest breakthroughs in quantum computing?',
  text: true,
);

print('Answer: ${answer.answer}');
print('Source count: ${answer.results.length}');

for (final source in answer.results) {
  print('Source: ${source.title} - ${source.url}');
  if (source.text != null) {
    print('Context: ${source.text!.substring(0, 200)}...');
  }
}
```

### 6. Find Similar

Find pages similar to a given URL.

```dart
final similarResults = await exa.findSimilar(
  url: 'https://arxiv.org/abs/2301.00001',
  numResults: 5,
  includeDomains: ['arxiv.org', 'openreview.net'],
  startPublishedDate: DateTime(2023, 1, 1),
  includeText: ['transformer', 'attention'],
  contents: const ContentsConfig(
    text: true,
    highlights: HighlightsConfig(
      numSentences: 1,
      highlightsPerUrl: 1,
    ),
    summary: SummaryConfig(query: 'Key innovations'),
  ),
);

print('Found ${similarResults.results.length} similar papers');
for (final result in similarResults.results) {
  print('${result.title}: ${result.url}');
  print('Similarity score: ${result.score}');
  if (result.summary != null) {
    print('Summary: ${result.summary}');
  }
}
```

## Configuration Options

### Search Types

```dart
SearchType.neural    // AI-powered semantic search (default for most queries)
SearchType.keyword   // Traditional keyword search
SearchType.auto      // Automatically choose the best search type
```

### Search Categories

```dart
SearchCategory.researchPaper
SearchCategory.tweet
SearchCategory.movie
SearchCategory.song
SearchCategory.personalSite
SearchCategory.company
SearchCategory.pdfDocument
```

### Livecrawl Options

```dart
LivecrawlOption.never      // Only use cached content
LivecrawlOption.fallback   // Use live crawl if not cached (default)
LivecrawlOption.always     // Always perform live crawl
LivecrawlOption.preferred  // Prefer live crawl when possible
```

### Content Configuration

```dart
// Text configuration
const textConfig = TextConfig(
  maxCharacters: 2000,
  includeHtmlTags: false,
);

// Highlights configuration
const highlights = HighlightsConfig(
  numSentences: 3,
  highlightsPerUrl: 2,
  query: 'important findings',
);

// Summary configuration
const summary = SummaryConfig(
  query: 'What are the main points?',
);

// Extras configuration (links, images)
const extras = ExtrasConfig(
  links: 10,
  imageLinks: 5,
);

// Complete contents configuration
const contents = ContentsConfig(
  text: true,
  textConfig: textConfig,
  highlights: highlights,
  summary: summary,
  extras: extras,
);
```

## Error Handling

The SDK throws `ExaApiException` for API errors:

```dart
try {
  final results = await exa.search(query: 'test query');
  // Process results...
} on ExaApiException catch (e) {
  print('API Error: ${e.message}');
  if (e.statusCode != null) {
    print('Status Code: ${e.statusCode}');
  }
} catch (e) {
  print('Unexpected error: $e');
}
```

## Cost Management

Monitor API usage costs:

```dart
final results = await exa.search(query: 'expensive query');

if (results.costDollars != null) {
  print('Search cost: \$${results.costDollars!.search}');
  print('Contents cost: \$${results.costDollars!.contents}');
  print('Total cost: \$${results.costDollars!.total}');
}
```

## Debug Mode

Enable debug mode to see request/response details:

```dart
final exa = ExaApi(
  apiKey: 'YOUR_API_KEY',
  debugMode: true, // Logs requests and responses
);
```

## Examples

See the [example file](example/exa_api_example.dart) for more comprehensive usage examples.

## License

This project is licensed under the MIT License.