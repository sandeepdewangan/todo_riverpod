import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/2-async-enum/pages/provider/todo_list/todo_list_provider.dart';
import 'package:todo_riverpod/2-async-enum/pages/provider/todo_list/todo_list_status.dart';

class NewTodo extends ConsumerWidget {
  NewTodo({super.key});

  final TextEditingController _controller = TextEditingController();
  Widget prevWidget = const SizedBox.shrink();

  bool enableOrNot(TodoListStatus status) {
    switch (status) {
      case TodoListStatus.failure when prevWidget is SizedBox:
      case TodoListStatus.loading || TodoListStatus.initial:
        return false;
      case _:
        prevWidget = Container();
        return true;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // When API request throws error, the UI shows try again message.
    // And with this error message, when we add a new todo,
    // the error message will be cleared and the new todo will be added.
    // The only newly added todo is shown rest are not shown.
    // To solve this we will disable the text field
    final todoListState = ref.watch(todoListProvider);

    return TextField(
      controller: _controller,
      enabled: enableOrNot(todoListState.status),
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
