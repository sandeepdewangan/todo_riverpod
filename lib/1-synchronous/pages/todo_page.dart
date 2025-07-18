import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/1-synchronous/pages/widgets/filter_todo.dart';
import 'package:todo_riverpod/1-synchronous/pages/widgets/new_todo.dart';
import 'package:todo_riverpod/1-synchronous/pages/widgets/search_todo.dart';
import 'package:todo_riverpod/1-synchronous/pages/widgets/show_todos.dart';
import 'package:todo_riverpod/1-synchronous/pages/widgets/toto_header.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TodoHeader(),
              const SizedBox(height: 15),
              NewTodo(),
              const SizedBox(height: 10),
              SearchTodo(),
              const SizedBox(height: 10),
              FilterTodo(),
              Expanded(child: ShowTodos()),
            ],
          ),
        ),
      ),
    );
  }
}
