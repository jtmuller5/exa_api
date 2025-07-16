import 'package:flutter/material.dart';
import 'package:exa_api/exa_api.dart';

void main() {
  runApp(const ExaApiExampleApp());
}

class ExaApiExampleApp extends StatelessWidget {
  const ExaApiExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exa API Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ExaApiDemo(),
    );
  }
}

class ExaApiDemo extends StatefulWidget {
  const ExaApiDemo({super.key});

  @override
  State<ExaApiDemo> createState() => _ExaApiDemoState();
}

class _ExaApiDemoState extends State<ExaApiDemo> {
  final _queryController = TextEditingController();
  final _urlController = TextEditingController();
  final _apiKeyController = TextEditingController();
  
  ExaApi? _exa;
  bool _isLoading = false;
  String _result = '';
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _queryController.text = 'Latest developments in AI';
    _urlController.text = 'https://arxiv.org/abs/2307.06435';
    // Note: In a real app, you'd store the API key securely
    _apiKeyController.text = 'YOUR_EXA_API_KEY_HERE';
  }

  void _initializeExa() {
    if (_apiKeyController.text.isNotEmpty && _apiKeyController.text != 'YOUR_EXA_API_KEY_HERE') {
      _exa = ExaApi(
        apiKey: _apiKeyController.text,
        debugMode: true,
      );
    }
  }

  Future<void> _performSearch() async {
    if (_exa == null) {
      _initializeExa();
      if (_exa == null) {
        _showError('Please enter a valid API key');
        return;
      }
    }

    if (_queryController.text.isEmpty) {
      _showError('Please enter a search query');
      return;
    }

    setState(() {
      _isLoading = true;
      _result = '';
    });

    try {
      final results = await _exa!.searchAndContents(
        query: _queryController.text,
        type: SearchType.neural,
        numResults: 3,
        text: true,
        highlights: const HighlightsConfig(
          numSentences: 2,
          highlightsPerUrl: 1,
        ),
        summary: const SummaryConfig(
          query: 'Key findings and main points',
        ),
        maxCharacters: 1000,
      );

      final buffer = StringBuffer();
      buffer.writeln('🔍 Search Results for: "${_queryController.text}"');
      buffer.writeln('Search Type: ${results.resolvedSearchType.name}');
      buffer.writeln('Total Results: ${results.results.length}');
      
      if (results.costDollars != null) {
        buffer.writeln('Cost: \$${results.costDollars!.total.toStringAsFixed(4)}');
      }
      
      buffer.writeln('\n' + '='*50 + '\n');

      for (int i = 0; i < results.results.length; i++) {
        final result = results.results[i];
        buffer.writeln('${i + 1}. ${result.title}');
        buffer.writeln('   URL: ${result.url}');
        buffer.writeln('   Author: ${result.author ?? 'Unknown'}');
        buffer.writeln('   Score: ${result.score?.toStringAsFixed(3) ?? 'N/A'}');
        
        if (result.summary != null) {
          buffer.writeln('   Summary: ${result.summary}');
        }
        
        if (result.highlights != null && result.highlights!.isNotEmpty) {
          buffer.writeln('   Highlights: ${result.highlights!.join(' | ')}');
        }
        
        if (result.text != null) {
          final text = result.text!.length > 200 
              ? '${result.text!.substring(0, 200)}...'
              : result.text!;
          buffer.writeln('   Content: $text');
        }
        
        buffer.writeln('\n' + '-'*30 + '\n');
      }

      setState(() {
        _result = buffer.toString();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _performAnswer() async {
    if (_exa == null) {
      _initializeExa();
      if (_exa == null) {
        _showError('Please enter a valid API key');
        return;
      }
    }

    if (_queryController.text.isEmpty) {
      _showError('Please enter a question');
      return;
    }

    setState(() {
      _isLoading = true;
      _result = '';
    });

    try {
      final answer = await _exa!.answer(
        query: _queryController.text,
        text: true,
      );

      final buffer = StringBuffer();
      buffer.writeln('❓ Question: "${_queryController.text}"');
      buffer.writeln('\n🤖 Answer: ${answer.answer}');
      buffer.writeln('\n📚 Sources (${answer.citations.length}):');
      
      for (int i = 0; i < answer.citations.length; i++) {
        final citation = answer.citations[i];
        buffer.writeln('${i + 1}. ${citation.title}');
        buffer.writeln('   URL: ${citation.url}');
        buffer.writeln('   Author: ${citation.author ?? 'Unknown'}');
        
        if (citation.text != null) {
          final text = citation.text!.length > 200 
              ? '${citation.text!.substring(0, 200)}...'
              : citation.text!;
          buffer.writeln('   Content: $text');
        }
        
        buffer.writeln('\n' + '-'*30 + '\n');
      }

      setState(() {
        _result = buffer.toString();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _performGetContents() async {
    if (_exa == null) {
      _initializeExa();
      if (_exa == null) {
        _showError('Please enter a valid API key');
        return;
      }
    }

    if (_urlController.text.isEmpty) {
      _showError('Please enter a URL');
      return;
    }

    setState(() {
      _isLoading = true;
      _result = '';
    });

    try {
      final contents = await _exa!.getContentsSimple(
        urls: [_urlController.text],
        text: true,
        highlights: const HighlightsConfig(
          numSentences: 3,
          highlightsPerUrl: 2,
        ),
        summary: const SummaryConfig(
          query: 'What are the main points?',
        ),
        maxCharacters: 2000,
      );

      final buffer = StringBuffer();
      buffer.writeln('📄 Content for: ${_urlController.text}');
      buffer.writeln('Request ID: ${contents.requestId}');
      buffer.writeln('Total Results: ${contents.results.length}');
      buffer.writeln('\n' + '='*50 + '\n');

      for (final result in contents.results) {
        buffer.writeln('Title: ${result.title}');
        buffer.writeln('URL: ${result.url}');
        buffer.writeln('Author: ${result.author ?? 'Unknown'}');
        buffer.writeln('Published: ${result.publishedDate?.toString() ?? 'Unknown'}');
        
        if (result.summary != null) {
          buffer.writeln('\nSummary: ${result.summary}');
        }
        
        if (result.highlights != null && result.highlights!.isNotEmpty) {
          buffer.writeln('\nHighlights:');
          for (int i = 0; i < result.highlights!.length; i++) {
            buffer.writeln('  ${i + 1}. ${result.highlights![i]}');
          }
        }
        
        if (result.text != null) {
          final text = result.text!.length > 500 
              ? '${result.text!.substring(0, 500)}...'
              : result.text!;
          buffer.writeln('\nContent: $text');
        }
        
        buffer.writeln('\n' + '-'*30 + '\n');
      }

      setState(() {
        _result = buffer.toString();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _performFindSimilar() async {
    if (_exa == null) {
      _initializeExa();
      if (_exa == null) {
        _showError('Please enter a valid API key');
        return;
      }
    }

    if (_urlController.text.isEmpty) {
      _showError('Please enter a URL');
      return;
    }

    setState(() {
      _isLoading = true;
      _result = '';
    });

    try {
      final similar = await _exa!.findSimilar(
        url: _urlController.text,
        numResults: 3,
        contents: const ContentsConfig(
          text: true,
          highlights: HighlightsConfig(
            numSentences: 2,
            highlightsPerUrl: 1,
          ),
          summary: SummaryConfig(
            query: 'Main topic and key insights',
          ),
        ),
      );

      final buffer = StringBuffer();
      buffer.writeln('🔗 Similar links to: ${_urlController.text}');
      buffer.writeln('Request ID: ${similar.requestId}');
      buffer.writeln('Total Results: ${similar.results.length}');
      buffer.writeln('\n' + '='*50 + '\n');

      for (int i = 0; i < similar.results.length; i++) {
        final result = similar.results[i];
        buffer.writeln('${i + 1}. ${result.title}');
        buffer.writeln('   URL: ${result.url}');
        buffer.writeln('   Author: ${result.author ?? 'Unknown'}');
        buffer.writeln('   Similarity Score: ${result.score?.toStringAsFixed(3) ?? 'N/A'}');
        
        if (result.summary != null) {
          buffer.writeln('   Summary: ${result.summary}');
        }
        
        if (result.highlights != null && result.highlights!.isNotEmpty) {
          buffer.writeln('   Highlights: ${result.highlights!.join(' | ')}');
        }
        
        if (result.text != null) {
          final text = result.text!.length > 200 
              ? '${result.text!.substring(0, 200)}...'
              : result.text!;
          buffer.writeln('   Content: $text');
        }
        
        buffer.writeln('\n' + '-'*30 + '\n');
      }

      setState(() {
        _result = buffer.toString();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _queryController.dispose();
    _urlController.dispose();
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exa API Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          // API Key Input
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _apiKeyController,
              decoration: const InputDecoration(
                labelText: 'Exa API Key',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.key),
                helperText: 'Get your API key from https://dashboard.exa.ai/',
              ),
              obscureText: true,
            ),
          ),
          
          // Tab Navigation
          Container(
            color: Theme.of(context).colorScheme.surface,
            child: Row(
              children: [
                _buildTabButton('Search', 0),
                _buildTabButton('Answer', 1),
                _buildTabButton('Contents', 2),
                _buildTabButton('Similar', 3),
              ],
            ),
          ),
          
          // Input Fields
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (_selectedTab == 0 || _selectedTab == 1) ...[
                  TextField(
                    controller: _queryController,
                    decoration: InputDecoration(
                      labelText: _selectedTab == 0 ? 'Search Query' : 'Question',
                      border: const OutlineInputBorder(),
                      prefixIcon: Icon(_selectedTab == 0 ? Icons.search : Icons.question_mark),
                    ),
                    maxLines: 2,
                  ),
                ] else ...[
                  TextField(
                    controller: _urlController,
                    decoration: const InputDecoration(
                      labelText: 'URL',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.link),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _getActionForTab(),
                    child: _isLoading 
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(_getButtonTextForTab()),
                  ),
                ),
              ],
            ),
          ),
          
          // Results
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _result.isEmpty
                  ? const Center(
                      child: Text(
                        'Results will appear here',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: SelectableText(
                        _result,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Theme.of(context).primaryColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  VoidCallback _getActionForTab() {
    switch (_selectedTab) {
      case 0:
        return _performSearch;
      case 1:
        return _performAnswer;
      case 2:
        return _performGetContents;
      case 3:
        return _performFindSimilar;
      default:
        return _performSearch;
    }
  }

  String _getButtonTextForTab() {
    switch (_selectedTab) {
      case 0:
        return 'Search';
      case 1:
        return 'Get Answer';
      case 2:
        return 'Get Contents';
      case 3:
        return 'Find Similar';
      default:
        return 'Search';
    }
  }
}
