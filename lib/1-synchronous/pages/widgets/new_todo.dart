import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/1-synchronous/pages/provider/todo_list/todo_list_provider.dart';

class NewTodo extends ConsumerWidget {
  NewTodo({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: 'Add Todo',
        border: OutlineInputBorder(),
      ),
      onSubmitted: (String? todo) {
        if (todo != null && todo.trim().isNotEmpty) {
          ref.watch(todoListProvider.notifier).addTodo(todo.trim());
          _controller.clear();
        }
      },
    );
  }
}
