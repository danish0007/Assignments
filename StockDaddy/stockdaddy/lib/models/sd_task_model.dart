import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sd_task_model.g.dart';

@CopyWith()
@JsonSerializable()
class SDTaskModel extends Equatable {
  const SDTaskModel({
    this.uid,
    this.tags,
    required this.title,
    required this.dateTime,
    required this.description,
  });

  final String title;
  final String description;
  final List<String>? tags;
  final DateTime dateTime;
  final String? uid;

  static String kTitle = 'title';
  static String kDescription = 'description';
  static String kTags = 'tags';
  static String kDateTime = 'dateTime';
  static String kUid = 'uid';

  /// for converting data received from database
  /// which is typically in Json format
  factory SDTaskModel.fromJson(Map<String, dynamic> json) =>
      _$SDTaskModelFromJson(json);

  /// for converting data to be sent from application
  /// to database
  Map<String, dynamic> toJson() => _$SDTaskModelToJson(this);

  // Use to map the values to the [OdCardModel] Model and return that model.
  static SDTaskModel mapToModel(SDTaskModel? model, Map<String, dynamic> map) {
    if (model != null) {
      return model.copyWith(
        title: map[SDTaskModel.kTitle] as String,
        description: map[SDTaskModel.kDescription] as String,
        tags: map[SDTaskModel.kTags] as List<String>?,
        dateTime: map[SDTaskModel.kDateTime] as DateTime,
        uid: map[SDTaskModel.kUid] as String?,
      );
    }

    return SDTaskModel(
      title: map[SDTaskModel.kTitle] as String,
      description: map[SDTaskModel.kDescription] as String,
      tags: (map[SDTaskModel.kTags] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      dateTime: map[SDTaskModel.kDateTime] as DateTime,
      uid: map[SDTaskModel.kUid] as String?,
    );
  }

  /// Returns the map of the [SDTaskModel] model
  static Map<String, dynamic> modelToMap(SDTaskModel? model) {
    return {
      SDTaskModel.kTitle: model?.title ?? '',
      SDTaskModel.kDescription: model?.description ?? '',
      SDTaskModel.kDateTime: model?.dateTime ?? DateTime.now(),
      SDTaskModel.kTags: model?.tags ?? [],
      SDTaskModel.kUid: model?.uid ?? '',
    };
  }

  @override
  List<Object?> get props => [
        tags,
        uid,
        title,
        dateTime,
        description,
      ];

// **************************************************************************
// JsonSerializable Conversions
// **************************************************************************

  static SDTaskModel _$SDTaskModelFromJson(Map<String, dynamic> json) {
    Timestamp? timestamp = json['dataTime'];
    return SDTaskModel(
      uid: json['uid'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      title: json['title'] as String? ?? '',
      dateTime: DateTime.fromMicrosecondsSinceEpoch(timestamp != null
          ? timestamp.microsecondsSinceEpoch
          : DateTime.now().microsecondsSinceEpoch),
      description: json['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> _$SDTaskModelToJson(SDTaskModel instance) =>
      <String, dynamic>{
        'title': instance.title,
        'description': instance.description,
        'tags': instance.tags,
        'dateTime': instance.dateTime.toIso8601String(),
        'uid': instance.uid,
      };
}
