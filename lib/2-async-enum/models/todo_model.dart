import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

Uuid uuid = const Uuid();

@freezed
abstract class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String desc,
    @Default(false) bool isCompleted,
  }) = _Todo;

  factory Todo.add({required String desc}) {
    return Todo(id: uuid.v4(), desc: desc);
  }

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}

enum Filter { all, active, completed }
