# Exa API Example

This example demonstrates how to use the Exa API Dart SDK in a Flutter application.

## Features

The example app showcases all four main Exa API endpoints:

1. **Search** - Perform semantic or keyword searches across the web
2. **Answer** - Get AI-powered answers to questions with citations
3. **Get Contents** - Extract content, summaries, and metadata from URLs
4. **Find Similar** - Find pages similar to a given URL

## Setup

1. Get your API key from [Exa Dashboard](https://dashboard.exa.ai/)
2. Enter your API key in the app
3. Try the different features with sample queries

## Usage

### Search
- Enter a search query like "Latest developments in AI"
- The app will perform a neural search and return results with:
  - Title, URL, author, and relevance score
  - AI-generated summaries
  - Key highlights
  - Content snippets

### Answer
- Ask a question like "What are the latest breakthroughs in quantum computing?"
- The app will return:
  - A direct AI-generated answer
  - Citations and sources used
  - Full content from source pages

### Get Contents
- Enter a URL like "https://arxiv.org/abs/2307.06435"
- The app will extract:
  - Full page content
  - AI-generated summary
  - Key highlights
  - Metadata (author, publish date, etc.)

### Find Similar
- Enter a URL to find similar pages
- The app will return:
  - Similar pages with similarity scores
  - Summaries of each similar page
  - Key highlights from similar content

## API Key Security

⚠️ **Important**: This example stores the API key in plain text for demonstration purposes. In a production app, you should:

- Store API keys securely (e.g., using flutter_secure_storage)
- Never commit API keys to version control
- Use environment variables or secure configuration

## Error Handling

The app includes basic error handling for:
- Invalid API keys
- Network errors
- Empty queries/URLs
- API rate limits

## Cost Monitoring

The app displays API usage costs when available, helping you monitor your Exa API usage.

## Customization

You can modify the example to:
- Change search parameters (number of results, search type)
- Adjust content extraction settings
- Add more sophisticated error handling
- Implement result caching
- Add data persistence

## Running the Example

```bash
cd example
flutter run
```

Make sure you have Flutter installed and configured properly.
