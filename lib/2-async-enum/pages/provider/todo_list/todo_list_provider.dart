import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod/2-async-enum/models/todo_model.dart';
import 'package:todo_riverpod/2-async-enum/pages/provider/todo_list/todo_list_status.dart';
import 'package:todo_riverpod/2-async-enum/repo/providers/todo_repo_provider.dart';

part 'todo_list_provider.g.dart';

@riverpod
class TodoList extends _$TodoList {
  @override
  TodoListState build() {
    return TodoListState.initial();
  }

  Future<void> getTodos() async {
    state = state.copyWith(status: TodoListStatus.loading);
    try {
      final todos = await ref.read(todoRepoProvider).getTodos();
      state = state.copyWith(status: TodoListStatus.success, todos: todos);
    } catch (e) {
      state = state.copyWith(
        status: TodoListStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> addTodo(String desc) async {
    state = state.copyWith(status: TodoListStatus.loading);
    try {
      final newTodo = Todo.add(desc: desc);
      await ref.read(todoRepoProvider).addTodo(todo: newTodo);
      state = state.copyWith(
        status: TodoListStatus.success,
        todos: [...state.todos, newTodo],
      );
    } catch (e) {
      state = state.copyWith(
        status: TodoListStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> editTodo(String id, String desc) async {
    state = state.copyWith(status: TodoListStatus.loading);
    try {
      await ref.read(todoRepoProvider).editTodo(id: id, desc: desc);
      state = state.copyWith(
        status: TodoListStatus.success,
        todos: state.todos.map((todo) {
          return todo.id == id ? todo.copyWith(desc: desc) : todo;
        }).toList(),
      );
    } catch (e) {
      state = state.copyWith(
        status: TodoListStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> toggleTodo(String id) async {
    state = state.copyWith(status: TodoListStatus.loading);
    try {
      await ref.read(todoRepoProvider).toggleTodo(id: id);
      state = state.copyWith(
        status: TodoListStatus.success,
        todos: state.todos.map((todo) {
          return todo.id == id
              ? todo.copyWith(isCompleted: !todo.isCompleted)
              : todo;
        }).toList(),
      );
    } catch (e) {
      state = state.copyWith(
        status: TodoListStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> removeTodo(String id) async {
    state = state.copyWith(status: TodoListStatus.loading);
    try {
      await ref.read(todoRepoProvider).removeTodo(id: id);
      state = state.copyWith(
        status: TodoListStatus.success,
        todos: state.todos.where((todo) => todo.id != id).toList(),
      );
    } catch (e) {
      state = state.copyWith(
        status: TodoListStatus.failure,
        errorMessage: e.toString(),
      );
    }
  }
}
