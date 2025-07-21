// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Todo _$TodoFromJson(Map<String, dynamic> json) => _Todo(
  id: json['id'] as String,
  desc: json['desc'] as String,
  isCompleted: json['isCompleted'] as bool? ?? false,
);

Map<String, dynamic> _$TodoToJson(_Todo instance) => <String, dynamic>{
  'id': instance.id,
  'desc': instance.desc,
  'isCompleted': instance.isCompleted,
};
