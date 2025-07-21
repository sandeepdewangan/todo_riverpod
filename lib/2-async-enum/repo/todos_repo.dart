import 'package:todo_riverpod/2-async-enum/models/todo_model.dart';

abstract class TodosRepo {
  Future<List<Todo>> getTodos();
  Future<void> addTodo({required Todo todo});
  Future<void> editTodo({required String id, required String desc});
  Future<void> toggleTodo({required String id});
  Future<void> removeTodo({required String id});
}
