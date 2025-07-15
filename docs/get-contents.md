# Get contents

> Get the full page contents, summaries, and metadata for a list of URLs.

Returns instant results from our cache, with automatic live crawling as fallback for uncached pages.

## OpenAPI

````yaml post /contents
paths:
  path: /contents
  method: post
  servers:
    - url: https://api.exa.ai
  request:
    security:
      - title: apikey
        parameters:
          query: {}
          header:
            x-api-key:
              type: apiKey
              description: >-
                API key can be provided either via x-api-key header or
                Authorization header with Bearer scheme
          cookie: {}
    parameters:
      path: {}
      query: {}
      header: {}
      cookie: {}
    body:
      application/json:
        schemaArray:
          - type: object
            properties:
              urls:
                allOf:
                  - type: array
                    description: >-
                      Array of URLs to crawl (backwards compatible with 'ids'
                      parameter).
                    items:
                      type: string
                    example:
                      - https://arxiv.org/pdf/2307.06435
              ids:
                allOf:
                  - type: array
                    deprecated: true
                    description: >-
                      Deprecated - use 'urls' instead. Array of document IDs
                      obtained from searches.
                    items:
                      type: string
                    example:
                      - https://arxiv.org/pdf/2307.06435
              text:
                allOf:
                  - oneOf:
                      - type: boolean
                        title: Simple text retrieval
                        description: >-
                          If true, returns full page text with default settings.
                          If false, disables text return.
                      - type: object
                        title: Advanced text options
                        description: >-
                          Advanced options for controlling text extraction. Use
                          this when you need to limit text length or include
                          HTML structure.
                        properties:
                          maxCharacters:
                            type: integer
                            description: >-
                              Maximum character limit for the full page text.
                              Useful for controlling response size and API
                              costs.
                            example: 1000
                          includeHtmlTags:
                            type: boolean
                            default: false
                            description: >-
                              Include HTML tags in the response, which can help
                              LLMs understand text structure and formatting.
                            example: false
              highlights:
                allOf:
                  - type: object
                    description: >-
                      Text snippets the LLM identifies as most relevant from
                      each page.
                    properties:
                      numSentences:
                        type: integer
                        default: 5
                        description: The number of sentences to return for each snippet.
                        example: 1
                      highlightsPerUrl:
                        type: integer
                        default: 1
                        description: The number of snippets to return for each result.
                        example: 1
                      query:
                        type: string
                        description: >-
                          Custom query to direct the LLM's selection of
                          highlights.
                        example: Key advancements
              summary:
                allOf:
                  - type: object
                    description: Summary of the webpage
                    properties:
                      query:
                        type: string
                        description: Custom query for the LLM-generated summary.
                        example: Main developments
                      schema:
                        type: object
                        description: >
                          JSON schema for structured output from summary. 

                          See
                          https://json-schema.org/overview/what-is-jsonschema
                          for JSON Schema documentation.
                        example:
                          $schema: http://json-schema.org/draft-07/schema#
                          title: Title
                          type: object
                          properties:
                            Property 1:
                              type: string
                              description: Description
                            Property 2:
                              type: string
                              enum:
                                - option 1
                                - option 2
                                - option 3
                              description: Description
                          required:
                            - Property 1
              livecrawl:
                allOf:
                  - type: string
                    enum:
                      - never
                      - fallback
                      - always
                      - preferred
                    description: >
                      Options for livecrawling pages.

                      'never': Disable livecrawling (default for neural search).

                      'fallback': Livecrawl when cache is empty (default for
                      keyword search).

                      'always': Always livecrawl.

                      'preferred': Always try to livecrawl, but fall back to
                      cache if crawling fails.
                    example: always
              livecrawlTimeout:
                allOf:
                  - type: integer
                    default: 10000
                    description: The timeout for livecrawling in milliseconds.
                    example: 1000
              subpages:
                allOf:
                  - type: integer
                    default: 0
                    description: >-
                      The number of subpages to crawl. The actual number crawled
                      may be limited by system constraints.
                    example: 1
              subpageTarget:
                allOf:
                  - oneOf:
                      - type: string
                      - type: array
                        items:
                          type: string
                    description: >-
                      Keyword to find specific subpages of search results. Can
                      be a single string or an array of strings, comma
                      delimited.
                    example: sources
              extras:
                allOf:
                  - type: object
                    description: Extra parameters to pass.
                    properties:
                      links:
                        type: integer
                        default: 0
                        description: Number of URLs to return from each webpage.
                        example: 1
                      imageLinks:
                        type: integer
                        default: 0
                        description: Number of images to return for each result.
                        example: 1
              context:
                allOf:
                  - oneOf:
                      - type: boolean
                        description: >-
                          Formats the search resutls into a context string ready
                          for LLMs.
                        example: true
                      - type: object
                        description: >-
                          Formats the search resutls into a context string ready
                          for LLMs.
                        properties:
                          maxCharacters:
                            type: integer
                            description: Maximum character limit.
                            example: 10000
            required: true
            refIdentifier: '#/components/schemas/ContentsRequest'
            requiredProperties:
              - urls
        examples:
          example:
            value:
              urls:
                - https://arxiv.org/pdf/2307.06435
              ids:
                - https://arxiv.org/pdf/2307.06435
              text: true
              highlights:
                numSentences: 1
                highlightsPerUrl: 1
                query: Key advancements
              summary:
                query: Main developments
                schema:
                  $schema: http://json-schema.org/draft-07/schema#
                  title: Title
                  type: object
                  properties:
                    Property 1:
                      type: string
                      description: Description
                    Property 2:
                      type: string
                      enum:
                        - option 1
                        - option 2
                        - option 3
                      description: Description
                  required:
                    - Property 1
              livecrawl: always
              livecrawlTimeout: 1000
              subpages: 1
              subpageTarget: sources
              extras:
                links: 1
                imageLinks: 1
              context: true
    codeSamples:
      - label: Simple contents retrieval
        lang: bash
        source: |
          curl -X POST 'https://api.exa.ai/contents' \
            -H 'x-api-key: YOUR-EXA-API-KEY' \
            -H 'Content-Type: application/json' \
            -d '{
              "urls": ["https://arxiv.org/abs/2307.06435"],
              "text": true
            }'
      - label: Simple contents retrieval
        lang: python
        source: |
          # pip install exa-py
          from exa_py import Exa
          exa = Exa('YOUR_EXA_API_KEY')

          results = exa.get_contents(
              urls=["https://arxiv.org/abs/2307.06435"],
              text=True
          )

          print(results)
      - label: Simple contents retrieval
        lang: javascript
        source: |
          // npm install exa-js
          import Exa from 'exa-js';
          const exa = new Exa('YOUR_EXA_API_KEY');

          const results = await exa.getContents(
              ["https://arxiv.org/abs/2307.06435"],
              { text: true }
          );

          console.log(results);
      - label: Simple contents retrieval
        lang: php
        source: ''
      - label: Simple contents retrieval
        lang: go
        source: ''
      - label: Simple contents retrieval
        lang: java
        source: ''
      - label: Advanced contents retrieval
        lang: bash
        source: |
          curl --request POST \
            --url https://api.exa.ai/contents \
            --header 'x-api-key: YOUR-EXA-API-KEY' \
            --header 'Content-Type: application/json' \
            --data '{
              "urls": ["https://arxiv.org/abs/2307.06435"],
              "text": {
                "maxCharacters": 1000,
                "includeHtmlTags": false
              },
              "highlights": {
                "numSentences": 3,
                "highlightsPerUrl": 2,
                "query": "Key findings"
              },
              "summary": {
                "query": "Main research contributions"
              },
              "subpages": 1,
              "subpageTarget": "references",
              "extras": {
                "links": 2,
                "imageLinks": 1
              }
            }'
      - label: Advanced contents retrieval
        lang: python
        source: |
          # pip install exa-py
          from exa_py import Exa
          exa = Exa('YOUR_EXA_API_KEY')

          results = exa.get_contents(
              urls=["https://arxiv.org/abs/2307.06435"],
              text={
                  "maxCharacters": 1000,
                  "includeHtmlTags": False
              },
              highlights={
                  "numSentences": 3,
                  "highlightsPerUrl": 2,
                  "query": "Key findings"
              },
              summary={
                  "query": "Main research contributions"
              },
              subpages=1,
              subpage_target="references",
              extras={
                  "links": 2,
                  "image_links": 1
              }
          )

          print(results)
      - label: Advanced contents retrieval
        lang: javascript
        source: |
          // npm install exa-js
          import Exa from 'exa-js';
          const exa = new Exa('YOUR_EXA_API_KEY');

          const results = await exa.getContents(
              ["https://arxiv.org/abs/2307.06435"],
              {
                  text: {
                      maxCharacters: 1000,
                      includeHtmlTags: false
                  },
                  highlights: {
                      numSentences: 3,
                      highlightsPerUrl: 2,
                      query: "Key findings"
                  },
                  summary: {
                      query: "Main research contributions"
                  },
                  subpages: 1,
                  subpageTarget: "references",
                  extras: {
                      links: 2,
                      imageLinks: 1
                  }
              }
          );

          console.log(results);
  response:
    '200':
      application/json:
        schemaArray:
          - type: object
            properties:
              requestId:
                allOf:
                  - type: string
                    description: Unique identifier for the request
                    example: e492118ccdedcba5088bfc4357a8a125
              results:
                allOf:
                  - type: array
                    items:
                      $ref: '#/components/schemas/ResultWithContent'
              context:
                allOf:
                  - type: string
                    description: A formatted string of the search results ready for LLMs.
              statuses:
                allOf:
                  - type: array
                    description: Status information for each requested URL
                    items:
                      type: object
                      properties:
                        id:
                          type: string
                          description: The URL that was requested
                          example: https://example.com
                        status:
                          type: string
                          enum:
                            - success
                            - error
                          description: Status of the content fetch operation
                          example: success
                        error:
                          type: object
                          nullable: true
                          description: Error details, only present when status is "error"
                          properties:
                            tag:
                              type: string
                              enum:
                                - CRAWL_NOT_FOUND
                                - CRAWL_TIMEOUT
                                - CRAWL_LIVECRAWL_TIMEOUT
                                - SOURCE_NOT_AVAILABLE
                                - CRAWL_UNKNOWN_ERROR
                              description: Specific error type
                              example: CRAWL_NOT_FOUND
                            httpStatusCode:
                              type: integer
                              nullable: true
                              description: The corresponding HTTP status code
                              example: 404
              costDollars:
                allOf:
                  - $ref: '#/components/schemas/CostDollars'
        examples:
          example:
            value:
              requestId: e492118ccdedcba5088bfc4357a8a125
              results:
                - title: A Comprehensive Overview of Large Language Models
                  url: https://arxiv.org/pdf/2307.06435.pdf
                  publishedDate: '2023-11-16T01:36:32.547Z'
                  author: >-
                    Humza  Naveed, University of Engineering and Technology
                    (UET), Lahore, Pakistan
                  score: 0.4600165784358978
                  id: https://arxiv.org/abs/2307.06435
                  image: https://arxiv.org/pdf/2307.06435.pdf/page_1.png
                  favicon: https://arxiv.org/favicon.ico
                  text: >-
                    Abstract Large Language Models (LLMs) have recently
                    demonstrated remarkable capabilities...
                  highlights:
                    - Such requirements have limited their adoption...
                  highlightScores:
                    - 0.4600165784358978
                  summary: >-
                    This overview paper on Large Language Models (LLMs)
                    highlights key developments...
                  subpages:
                    - id: https://arxiv.org/abs/2303.17580
                      url: https://arxiv.org/pdf/2303.17580.pdf
                      title: >-
                        HuggingGPT: Solving AI Tasks with ChatGPT and its
                        Friends in Hugging Face
                      author: >-
                        Yongliang  Shen, Microsoft Research Asia, Kaitao  Song,
                        Microsoft Research Asia, Xu  Tan, Microsoft Research
                        Asia, Dongsheng  Li, Microsoft Research Asia, Weiming 
                        Lu, Microsoft Research Asia, Yueting  Zhuang, Microsoft
                        Research Asia, yzhuang@zju.edu.cn, Zhejiang  University,
                        Microsoft Research Asia, Microsoft  Research, Microsoft
                        Research Asia
                      publishedDate: '2023-11-16T01:36:20.486Z'
                      text: >-
                        HuggingGPT: Solving AI Tasks with ChatGPT and its
                        Friends in Hugging Face Date Published: 2023-05-25
                        Authors: Yongliang Shen, Microsoft Research Asia Kaitao
                        Song, Microsoft Research Asia Xu Tan, Microsoft Research
                        Asia Dongsheng Li, Microsoft Research Asia Weiming Lu,
                        Microsoft Research Asia Yueting Zhuang, Microsoft
                        Research Asia, yzhuang@zju.edu.cn Zhejiang University,
                        Microsoft Research Asia Microsoft Research, Microsoft
                        Research Asia Abstract Solving complicated AI tasks with
                        different domains and modalities is a key step toward
                        artificial general intelligence. While there are
                        abundant AI models available for different domains and
                        modalities, they cannot handle complicated AI tasks.
                        Considering large language models (LLMs) have exhibited
                        exceptional ability in language understanding,
                        generation, interaction, and reasoning, we advocate that
                        LLMs could act as a controller to manage existing AI
                        models to solve complicated AI tasks and language could
                        be a generic interface to empower t
                      summary: >-
                        HuggingGPT is a framework using ChatGPT as a central
                        controller to orchestrate various AI models from Hugging
                        Face to solve complex tasks. ChatGPT plans the task,
                        selects appropriate models based on their descriptions,
                        executes subtasks, and summarizes the results. This
                        approach addresses limitations of LLMs by allowing them
                        to handle multimodal data (vision, speech) and
                        coordinate multiple models for complex tasks, paving the
                        way for more advanced AI systems.
                      highlights:
                        - >-
                          2) Recently, some researchers started to investigate
                          the integration of using tools or models in LLMs  .
                      highlightScores:
                        - 0.32679107785224915
                  extras:
                    links: []
              context: <string>
              statuses:
                - id: https://example.com
                  status: success
                  error:
                    tag: CRAWL_NOT_FOUND
                    httpStatusCode: 404
              costDollars:
                total: 0.005
                breakDown:
                  - search: 0.005
                    contents: 0
                    breakdown:
                      keywordSearch: 0
                      neuralSearch: 0.005
                      contentText: 0
                      contentHighlight: 0
                      contentSummary: 0
                perRequestPrices:
                  neuralSearch_1_25_results: 0.005
                  neuralSearch_26_100_results: 0.025
                  neuralSearch_100_plus_results: 1
                  keywordSearch_1_100_results: 0.0025
                  keywordSearch_100_plus_results: 3
                perPagePrices:
                  contentText: 0.001
                  contentHighlight: 0.001
                  contentSummary: 0.001
        description: OK
  deprecated: false
  type: path
components:
  schemas:
    Result:
      type: object
      properties:
        title:
          type: string
          description: The title of the search result.
          example: A Comprehensive Overview of Large Language Models
        url:
          type: string
          format: uri
          description: The URL of the search result.
          example: https://arxiv.org/pdf/2307.06435.pdf
        publishedDate:
          type: string
          nullable: true
          description: >-
            An estimate of the creation date, from parsing HTML content. Format
            is YYYY-MM-DD.
          example: '2023-11-16T01:36:32.547Z'
        author:
          type: string
          nullable: true
          description: If available, the author of the content.
          example: >-
            Humza  Naveed, University of Engineering and Technology (UET),
            Lahore, Pakistan
        score:
          type: number
          nullable: true
          description: >-
            A number from 0 to 1 representing similarity between the query/url
            and the result.
          example: 0.4600165784358978
        id:
          type: string
          description: The temporary ID for the document. Useful for /contents endpoint.
          example: https://arxiv.org/abs/2307.06435
        image:
          type: string
          format: uri
          description: The URL of an image associated with the search result, if available.
          example: https://arxiv.org/pdf/2307.06435.pdf/page_1.png
        favicon:
          type: string
          format: uri
          description: The URL of the favicon for the search result's domain.
          example: https://arxiv.org/favicon.ico
    ResultWithContent:
      allOf:
        - $ref: '#/components/schemas/Result'
        - type: object
          properties:
            text:
              type: string
              description: The full content text of the search result.
              example: >-
                Abstract Large Language Models (LLMs) have recently demonstrated
                remarkable capabilities...
            highlights:
              type: array
              items:
                type: string
              description: Array of highlights extracted from the search result content.
              example:
                - Such requirements have limited their adoption...
            highlightScores:
              type: array
              items:
                type: number
                format: float
              description: Array of cosine similarity scores for each highlighted
              example:
                - 0.4600165784358978
            summary:
              type: string
              description: Summary of the webpage
              example: >-
                This overview paper on Large Language Models (LLMs) highlights
                key developments...
            subpages:
              type: array
              items:
                $ref: '#/components/schemas/ResultWithContent'
              description: Array of subpages for the search result.
              example:
                - id: https://arxiv.org/abs/2303.17580
                  url: https://arxiv.org/pdf/2303.17580.pdf
                  title: >-
                    HuggingGPT: Solving AI Tasks with ChatGPT and its Friends in
                    Hugging Face
                  author: >-
                    Yongliang  Shen, Microsoft Research Asia, Kaitao  Song,
                    Microsoft Research Asia, Xu  Tan, Microsoft Research Asia,
                    Dongsheng  Li, Microsoft Research Asia, Weiming  Lu,
                    Microsoft Research Asia, Yueting  Zhuang, Microsoft Research
                    Asia, yzhuang@zju.edu.cn, Zhejiang  University, Microsoft
                    Research Asia, Microsoft  Research, Microsoft Research Asia
                  publishedDate: '2023-11-16T01:36:20.486Z'
                  text: >-
                    HuggingGPT: Solving AI Tasks with ChatGPT and its Friends in
                    Hugging Face Date Published: 2023-05-25 Authors: Yongliang
                    Shen, Microsoft Research Asia Kaitao Song, Microsoft
                    Research Asia Xu Tan, Microsoft Research Asia Dongsheng Li,
                    Microsoft Research Asia Weiming Lu, Microsoft Research Asia
                    Yueting Zhuang, Microsoft Research Asia, yzhuang@zju.edu.cn
                    Zhejiang University, Microsoft Research Asia Microsoft
                    Research, Microsoft Research Asia Abstract Solving
                    complicated AI tasks with different domains and modalities
                    is a key step toward artificial general intelligence. While
                    there are abundant AI models available for different domains
                    and modalities, they cannot handle complicated AI tasks.
                    Considering large language models (LLMs) have exhibited
                    exceptional ability in language understanding, generation,
                    interaction, and reasoning, we advocate that LLMs could act
                    as a controller to manage existing AI models to solve
                    complicated AI tasks and language could be a generic
                    interface to empower t
                  summary: >-
                    HuggingGPT is a framework using ChatGPT as a central
                    controller to orchestrate various AI models from Hugging
                    Face to solve complex tasks. ChatGPT plans the task, selects
                    appropriate models based on their descriptions, executes
                    subtasks, and summarizes the results. This approach
                    addresses limitations of LLMs by allowing them to handle
                    multimodal data (vision, speech) and coordinate multiple
                    models for complex tasks, paving the way for more advanced
                    AI systems.
                  highlights:
                    - >-
                      2) Recently, some researchers started to investigate the
                      integration of using tools or models in LLMs  .
                  highlightScores:
                    - 0.32679107785224915
            extras:
              type: object
              description: Results from extras.
              properties:
                links:
                  type: array
                  items:
                    type: string
                  description: Array of links from the search result.
                  example: []
    CostDollars:
      type: object
      properties:
        total:
          type: number
          format: float
          description: Total dollar cost for your request
          example: 0.005
        breakDown:
          type: array
          description: Breakdown of costs by operation type
          items:
            type: object
            properties:
              search:
                type: number
                format: float
                description: Cost of your search operations
                example: 0.005
              contents:
                type: number
                format: float
                description: Cost of your content operations
                example: 0
              breakdown:
                type: object
                properties:
                  keywordSearch:
                    type: number
                    format: float
                    description: Cost of your keyword search operations
                    example: 0
                  neuralSearch:
                    type: number
                    format: float
                    description: Cost of your neural search operations
                    example: 0.005
                  contentText:
                    type: number
                    format: float
                    description: Cost of your text content retrieval
                    example: 0
                  contentHighlight:
                    type: number
                    format: float
                    description: Cost of your highlight generation
                    example: 0
                  contentSummary:
                    type: number
                    format: float
                    description: Cost of your summary generation
                    example: 0
        perRequestPrices:
          type: object
          description: Standard price per request for different operations
          properties:
            neuralSearch_1_25_results:
              type: number
              format: float
              description: Standard price for neural search with 1-25 results
              example: 0.005
            neuralSearch_26_100_results:
              type: number
              format: float
              description: Standard price for neural search with 26-100 results
              example: 0.025
            neuralSearch_100_plus_results:
              type: number
              format: float
              description: Standard price for neural search with 100+ results
              example: 1
            keywordSearch_1_100_results:
              type: number
              format: float
              description: Standard price for keyword search with 1-100 results
              example: 0.0025
            keywordSearch_100_plus_results:
              type: number
              format: float
              description: Standard price for keyword search with 100+ results
              example: 3
        perPagePrices:
          type: object
          description: Standard price per page for different content operations
          properties:
            contentText:
              type: number
              format: float
              description: Standard price per page for text content
              example: 0.001
            contentHighlight:
              type: number
              format: float
              description: Standard price per page for highlights
              example: 0.001
            contentSummary:
              type: number
              format: float
              description: Standard price per page for summaries
              example: 0.001

````