import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_riverpod/2-async-enum/models/todo_model.dart';
part 'todo_list_status.freezed.dart';

enum TodoListStatus { initial, loading, success, failure }

@freezed
abstract class TodoListState with _$TodoListState {
  const factory TodoListState({
    required TodoListStatus status,
    required List<Todo> todos,
    required String errorMessage,
  }) = _TodoListState;

  factory TodoListState.initial() => TodoListState(
    status: TodoListStatus.initial,
    todos: [],
    errorMessage: '',
  );
}
