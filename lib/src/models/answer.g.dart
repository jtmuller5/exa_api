// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerRequest _$AnswerRequestFromJson(Map<String, dynamic> json) =>
    AnswerRequest(
      query: json['query'] as String,
      stream: json['stream'] as bool? ?? false,
      text: json['text'] as bool? ?? false,
    );

Map<String, dynamic> _$AnswerRequestToJson(AnswerRequest instance) =>
    <String, dynamic>{
      'query': instance.query,
      'stream': instance.stream,
      'text': instance.text,
    };

AnswerCitation _$AnswerCitationFromJson(Map<String, dynamic> json) =>
    AnswerCitation(
      id: json['id'] as String,
      url: json['url'] as String,
      title: json['title'] as String,
      author: json['author'] as String?,
      publishedDate: json['publishedDate'] as String?,
      text: json['text'] as String?,
      image: json['image'] as String?,
      favicon: json['favicon'] as String?,
    );

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
    AnswerResponse(
      answer: json['answer'] as String,
      citations: (json['citations'] as List<dynamic>)
          .map((e) => AnswerCitation.fromJson(e as Map<String, dynamic>))
          .toList(),
      costDollars: json['costDollars'] == null
          ? null
          : CostDollars.fromJson(json['costDollars'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnswerResponseToJson(AnswerResponse instance) =>
    <String, dynamic>{
      'answer': instance.answer,
      'citations': instance.citations,
      'costDollars': instance.costDollars,
    };
