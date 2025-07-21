import 'dart:math';

import 'package:todo_riverpod/2-async-enum/models/todo_model.dart';
import 'package:todo_riverpod/2-async-enum/repo/todos_repo.dart';

final intialTodos = [
  {'id': '1', "desc": 'Buy groceries', "isCompleted": false},
  {'id': '2', "desc": 'Walk the dog', "isCompleted": false},
  {'id': '3', "desc": 'Read a book', "isCompleted": false},
];

const double kProbablityOfError = 0.5;
const int kDelayInSeconds = 1;

class FakeTodoRepo extends TodosRepo {
  List<Map<String, dynamic>> todos = intialTodos;
  final Random random = Random();

  Future<void> waitSeconds() async {
    await Future.delayed(const Duration(seconds: kDelayInSeconds));
  }

  @override
  Future<List<Todo>> getTodos() async {
    await waitSeconds();
    try {
      // simulate a random error
      if (random.nextDouble() < kProbablityOfError) {
        throw 'Failed to fetch todos';
      }
      return [for (final todo in todos) Todo.fromJson(todo)];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addTodo({required Todo todo}) async {
    await waitSeconds();
    try {
      // simulate a random error
      if (random.nextDouble() < kProbablityOfError) {
        throw 'Failed to add todo';
      }
      todos = [...todos, todo.toJson()];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> editTodo({required String id, required String desc}) async {
    await waitSeconds();
    try {
      // simulate a random error
      if (random.nextDouble() < kProbablityOfError) {
        throw 'Failed to edit todo';
      }
      todos = [
        for (final todo in todos)
          if (todo['id'] == id)
            {'id': id, 'desc': desc, 'isCompleted': todo['isCompleted']}
          else
            todo,
      ];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeTodo({required String id}) async {
    await waitSeconds();
    try {
      // simulate a random error
      if (random.nextDouble() < kProbablityOfError) {
        throw 'Failed to remove todo';
      }
      todos = [
        for (final todo in todos)
          if (todo['id'] != id) todo,
      ];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> toggleTodo({required String id}) async {
    await waitSeconds();
    try {
      // simulate a random error
      if (random.nextDouble() < kProbablityOfError) {
        throw 'Failed to toggle todo';
      }
      todos = [
        for (final todo in todos)
          if (todo['id'] == id)
            {
              'id': id,
              'desc': todo['desc'],
              'isCompleted': !todo['isCompleted'],
            }
          else
            todo,
      ];
    } catch (e) {
      rethrow;
    }
  }
}
