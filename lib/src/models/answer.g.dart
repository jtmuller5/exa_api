// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerRequest _$AnswerRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AnswerRequest', json, ($checkedConvert) {
      final val = AnswerRequest(
        query: $checkedConvert('query', (v) => v as String),
        stream: $checkedConvert('stream', (v) => v as bool? ?? false),
        text: $checkedConvert('text', (v) => v as bool? ?? false),
      );
      return val;
    });

Map<String, dynamic> _$AnswerRequestToJson(AnswerRequest instance) =>
    <String, dynamic>{
      'query': instance.query,
      'stream': instance.stream,
      'text': instance.text,
    };

AnswerCitation _$AnswerCitationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AnswerCitation', json, ($checkedConvert) {
      final val = AnswerCitation(
        id: $checkedConvert('id', (v) => v as String),
        url: $checkedConvert('url', (v) => v as String),
        title: $checkedConvert('title', (v) => v as String),
        author: $checkedConvert('author', (v) => v as String?),
        publishedDate: $checkedConvert('publishedDate', (v) => v as String?),
        text: $checkedConvert('text', (v) => v as String?),
        image: $checkedConvert('image', (v) => v as String?),
        favicon: $checkedConvert('favicon', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$AnswerCitationToJson(AnswerCitation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'title': instance.title,
      'author': instance.author,
      'publishedDate': instance.publishedDate,
      'text': instance.text,
      'image': instance.image,
      'favicon': instance.favicon,
    };

AnswerResponse _$AnswerResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AnswerResponse', json, ($checkedConvert) {
      final val = AnswerResponse(
        answer: $checkedConvert('answer', (v) => v as String),
        citations: $checkedConvert(
          'citations',
          (v) => (v as List<dynamic>)
              .map((e) => AnswerCitation.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        costDollars: $checkedConvert(
          'costDollars',
          (v) => v == null
              ? null
              : CostDollars.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$AnswerResponseToJson(AnswerResponse instance) =>
    <String, dynamic>{
      'answer': instance.answer,
      'citations': instance.citations.map((e) => e.toJson()).toList(),
      'costDollars': instance.costDollars?.toJson(),
    };
