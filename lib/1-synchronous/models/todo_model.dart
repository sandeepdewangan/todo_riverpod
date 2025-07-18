import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'todo_model.freezed.dart';

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
}

enum Filter { all, active, completed }
