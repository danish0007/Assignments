// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sd_task_model.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension SDTaskModelCopyWith on SDTaskModel {
  SDTaskModel copyWith({
    DateTime? dateTime,
    String? description,
    List<String>? tags,
    String? title,
    String? uid,
  }) {
    return SDTaskModel(
      dateTime: dateTime ?? this.dateTime,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      title: title ?? this.title,
      uid: uid ?? this.uid,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SDTaskModel _$SDTaskModelFromJson(Map<String, dynamic> json) => SDTaskModel(
      uid: json['uid'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      title: json['title'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      description: json['description'] as String,
    );

Map<String, dynamic> _$SDTaskModelToJson(SDTaskModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'tags': instance.tags,
      'dateTime': instance.dateTime.toIso8601String(),
      'uid': instance.uid,
    };
