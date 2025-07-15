# Answer

> Get an LLM answer to a question informed by Exa search results. `/answer` performs an Exa search and uses an LLM to generate either:
1. A direct answer for specific queries. (i.e. "What is the capital of France?" would return "Paris")
2. A detailed summary with citations for open-ended queries (i.e. "What is the state of ai in healthcare?" would return a summary with citations to relevant sources)

The response includes both the generated answer and the sources used to create it. The endpoint also supports streaming (as `stream=True`), which will returns tokens as they are generated.

Alternatively, you can use the OpenAI compatible [chat completions interface](https://docs.exa.ai/reference/chat-completions#answer).


## OpenAPI

````yaml post /answer
paths:
  path: /answer
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
              query:
                allOf:
                  - type: string
                    description: The question or query to answer.
                    example: What is the latest valuation of SpaceX?
                    minLength: 1
              stream:
                allOf:
                  - type: boolean
                    default: false
                    description: >-
                      If true, the response is returned as a server-sent events
                      (SSS) stream.
              text:
                allOf:
                  - type: boolean
                    default: false
                    description: >-
                      If true, the response includes full text content in the
                      search results
            required: true
            requiredProperties:
              - query
        examples:
          example:
            value:
              query: What is the latest valuation of SpaceX?
              stream: false
              text: false
    codeSamples:
      - label: Simple answer
        lang: bash
        source: |
          curl -X POST 'https://api.exa.ai/answer' \
            -H 'x-api-key: YOUR-EXA-API-KEY' \
            -H 'Content-Type: application/json' \
            -d '{
              "query": "What is the latest valuation of SpaceX?",
              "text": true
            }'
      - label: Simple answer
        lang: python
        source: |
          # pip install exa-py
          from exa_py import Exa
          exa = Exa('YOUR_EXA_API_KEY')

          result = exa.answer(
              "What is the latest valuation of SpaceX?",
              text=True
          )

          print(result)
      - label: Simple answer
        lang: javascript
        source: |
          // npm install exa-js
          import Exa from 'exa-js';
          const exa = new Exa('YOUR_EXA_API_KEY');

          const result = await exa.answer(
              'What is the latest valuation of SpaceX?',
              { text: true }
          );

          console.log(result);
      - label: Simple answer
        lang: php
        source: ''
      - label: Simple answer
        lang: go
        source: ''
      - label: Simple answer
        lang: java
        source: ''
  response:
    '200':
      application/json:
        schemaArray:
          - type: object
            properties:
              answer:
                allOf:
                  - type: string
                    description: The generated answer based on search results.
                    example: $350 billion.
              citations:
                allOf:
                  - type: array
                    description: Search results used to generate the answer.
                    items:
                      $ref: '#/components/schemas/AnswerCitation'
              costDollars:
                allOf:
                  - $ref: '#/components/schemas/CostDollars'
            refIdentifier: '#/components/schemas/AnswerResult'
        examples:
          example:
            value:
              answer: $350 billion.
              citations:
                - id: >-
                    https://www.theguardian.com/science/2024/dec/11/spacex-valued-at-350bn-as-company-agrees-to-buy-shares-from-employees
                  url: >-
                    https://www.theguardian.com/science/2024/dec/11/spacex-valued-at-350bn-as-company-agrees-to-buy-shares-from-employees
                  title: >-
                    SpaceX valued at $350bn as company agrees to buy shares from
                    ...
                  author: Dan Milmon
                  publishedDate: '2023-11-16T01:36:32.547Z'
                  text: >-
                    SpaceX valued at $350bn as company agrees to buy shares from
                    ...
                  image: >-
                    https://i.guim.co.uk/img/media/7cfee7e84b24b73c97a079c402642a333ad31e77/0_380_6176_3706/master/6176.jpg?width=1200&height=630&quality=85&auto=format&fit=crop&overlay-align=bottom%2Cleft&overlay-width=100p&overlay-base64=L2ltZy9zdGF0aWMvb3ZlcmxheXMvdGctZGVmYXVsdC5wbmc&enable=upscale&s=71ebb2fbf458c185229d02d380c01530
                  favicon: >-
                    https://assets.guim.co.uk/static/frontend/icons/homescreen/apple-touch-icon.svg
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
      text/event-stream:
        schemaArray:
          - type: object
            properties:
              answer:
                allOf:
                  - type: string
                    description: Partial answer chunk when streaming is enabled.
              citations:
                allOf:
                  - type: array
                    items:
                      $ref: '#/components/schemas/AnswerCitation'
        examples:
          example:
            value:
              answer: <string>
              citations:
                - id: >-
                    https://www.theguardian.com/science/2024/dec/11/spacex-valued-at-350bn-as-company-agrees-to-buy-shares-from-employees
                  url: >-
                    https://www.theguardian.com/science/2024/dec/11/spacex-valued-at-350bn-as-company-agrees-to-buy-shares-from-employees
                  title: >-
                    SpaceX valued at $350bn as company agrees to buy shares from
                    ...
                  author: Dan Milmon
                  publishedDate: '2023-11-16T01:36:32.547Z'
                  text: >-
                    SpaceX valued at $350bn as company agrees to buy shares from
                    ...
                  image: >-
                    https://i.guim.co.uk/img/media/7cfee7e84b24b73c97a079c402642a333ad31e77/0_380_6176_3706/master/6176.jpg?width=1200&height=630&quality=85&auto=format&fit=crop&overlay-align=bottom%2Cleft&overlay-width=100p&overlay-base64=L2ltZy9zdGF0aWMvb3ZlcmxheXMvdGctZGVmYXVsdC5wbmc&enable=upscale&s=71ebb2fbf458c185229d02d380c01530
                  favicon: >-
                    https://assets.guim.co.uk/static/frontend/icons/homescreen/apple-touch-icon.svg
        description: OK
  deprecated: false
  type: path
components:
  schemas:
    AnswerCitation:
      type: object
      properties:
        id:
          type: string
          description: The temporary ID for the document.
          example: >-
            https://www.theguardian.com/science/2024/dec/11/spacex-valued-at-350bn-as-company-agrees-to-buy-shares-from-employees
        url:
          type: string
          format: uri
          description: The URL of the search result.
          example: >-
            https://www.theguardian.com/science/2024/dec/11/spacex-valued-at-350bn-as-company-agrees-to-buy-shares-from-employees
        title:
          type: string
          description: The title of the search result.
          example: SpaceX valued at $350bn as company agrees to buy shares from ...
        author:
          type: string
          nullable: true
          description: If available, the author of the content.
          example: Dan Milmon
        publishedDate:
          type: string
          nullable: true
          description: >-
            An estimate of the creation date, from parsing HTML content. Format
            is YYYY-MM-DD.
          example: '2023-11-16T01:36:32.547Z'
        text:
          type: string
          description: >-
            The full text content of each source. Only present when includeText
            is enabled.
          example: SpaceX valued at $350bn as company agrees to buy shares from ...
        image:
          type: string
          format: uri
          description: >-
            The URL of the image associated with the search result, if
            available.
          example: >-
            https://i.guim.co.uk/img/media/7cfee7e84b24b73c97a079c402642a333ad31e77/0_380_6176_3706/master/6176.jpg?width=1200&height=630&quality=85&auto=format&fit=crop&overlay-align=bottom%2Cleft&overlay-width=100p&overlay-base64=L2ltZy9zdGF0aWMvb3ZlcmxheXMvdGctZGVmYXVsdC5wbmc&enable=upscale&s=71ebb2fbf458c185229d02d380c01530
        favicon:
          type: string
          format: uri
          description: The URL of the favicon for the search result's domain, if available.
          example: >-
            https://assets.guim.co.uk/static/frontend/icons/homescreen/apple-touch-icon.svg
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