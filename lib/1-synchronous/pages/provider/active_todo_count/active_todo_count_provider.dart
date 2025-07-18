import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod/1-synchronous/pages/provider/todo_list/todo_list_provider.dart';

part 'active_todo_count_provider.g.dart';

@riverpod
int activeTodoCount(ref) {
  final todos = ref.watch(todoListProvider);
  return todos.where((todo) => !todo.isCompleted).toList().length;
}
