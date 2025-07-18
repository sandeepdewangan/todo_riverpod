import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod/1-synchronous/models/todo_model.dart';

part 'todo_list_provider.g.dart';

@riverpod
class TodoList extends _$TodoList {
  @override
  List<Todo> build() {
    return [
      Todo(id: '1', desc: 'Buy groceries'),
      Todo(id: '2', desc: 'Walk the dog'),
      Todo(id: '3', desc: 'Read a book'),
    ];
  }

  void addTodo(String desc) {
    state = [...state, Todo.add(desc: desc)];
  }

  void editTodo(String id, String desc) {
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(desc: desc) else todo,
    ];
  }

  void toggleTodo(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          todo.copyWith(isCompleted: !todo.isCompleted)
        else
          todo,
    ];
  }

  void removeTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}
