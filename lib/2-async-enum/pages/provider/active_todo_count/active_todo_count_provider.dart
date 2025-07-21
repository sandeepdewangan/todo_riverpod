import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod/2-async-enum/pages/provider/todo_list/todo_list_provider.dart';

part 'active_todo_count_provider.g.dart';

@riverpod
int activeTodoCount(ref) {
  final todoListState = ref.watch(todoListProvider);
  return todoListState.todos.where((todo) => !todo.isCompleted).toList().length;
}


// return todoListState.where((todo) => !todo.isCompleted).toList().length;