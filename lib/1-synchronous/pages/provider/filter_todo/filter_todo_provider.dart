import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod/1-synchronous/models/todo_model.dart';
import 'package:todo_riverpod/1-synchronous/pages/provider/search/search_provider.dart';
import 'package:todo_riverpod/1-synchronous/pages/provider/todo_filter/todo_filter_provider.dart';
import 'package:todo_riverpod/1-synchronous/pages/provider/todo_list/todo_list_provider.dart';

part 'filter_todo_provider.g.dart';

@riverpod
List<Todo> filteredTodos(ref) {
  final todos = ref.watch(todoListProvider);
  final Filter filter = ref.watch(todoFilterProvider);
  final search = ref.watch(searchProvider);

  final List<Todo> tempTodos;
  tempTodos = switch (filter) {
    Filter.active => todos.where((todo) => !todo.isCompleted).toList(),
    Filter.completed =>
      todos.where((todo) => todo.isCompleted == true).toList(),
    Filter.all => todos,
  };

  if (search.isNotEmpty) {
    return tempTodos
        .where((todo) => todo.desc.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }
  return tempTodos;
}
