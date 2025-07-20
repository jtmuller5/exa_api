## 1.1.0

🟩 **[Added]**: Environment variable support for API key via `EXA_API_KEY` using `String.fromEnvironment()`

🟩 **[Added]**: Flexible authentication with optional `apiKey` constructor parameter

🟩 **[Added]**: Comprehensive null safety for all response model fields

🟩 **[Added]**: Enhanced documentation with authentication options and usage examples

🟩 **[Added]**: Migration guide for upgrading from 1.0.x

🟨 **[Changed]**: **BREAKING** - All response model fields are now nullable to handle uncertain API responses:
  - `AnswerResponse`: `answer`, `citations` → nullable
  - `AnswerCitation`: `id`, `url`, `title` → nullable  
  - `SearchResponse`: `requestId`, `resolvedSearchType`, `results` → nullable
  - `SearchResult`: `title`, `url`, `id` → nullable
  - `CostBreakdown`: `search`, `contents`, `breakdown` → nullable
  - `ContentsResponse`: `requestId`, `results` → nullable
  - `ContentStatus`: `id`, `status` → nullable

🟨 **[Changed]**: Constructor now accepts optional `apiKey` parameter instead of required

🟨 **[Changed]**: Updated README with compile-time environment variable setup instructions

🟨 **[Changed]**: Enhanced example applications with null-safe access patterns

🟨 **[Changed]**: Improved class and method documentation

🟪 **[Fixed]**: Proper error handling in example applications for nullable response fields

🟪 **[Fixed]**: Add more robust handling for improper date formats

### Migration from 1.0.x
When upgrading from version 1.0.x, update your code to handle nullable response fields:

```dart
// Before (1.0.x)
print('Title: ${result.title}');
print('Found ${results.results.length} results');

// After (1.1.0+)
print('Title: ${result.title ?? 'No title'}');
print('Found ${results.results?.length ?? 0} results');
```

## 1.0.2

- Initial version.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

# Types of Changes
- 🟩 Added
- 🟨 Changed
- 🟧 Deprecated
- 🟥 Removed
- 🟪 Fixed
- 🟦 Security