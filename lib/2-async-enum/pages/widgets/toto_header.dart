import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todo_riverpod/2-async-enum/models/todo_model.dart';
import 'package:todo_riverpod/2-async-enum/pages/provider/theme/theme_provider.dart';
import 'package:todo_riverpod/2-async-enum/pages/provider/todo_list/todo_list_provider.dart';
import 'package:todo_riverpod/2-async-enum/pages/provider/todo_list/todo_list_status.dart';

class TodoHeader extends ConsumerWidget {
  const TodoHeader({super.key});

  int getTodoCount(List<Todo> todos) {
    return todos.where((todo) => !todo.isCompleted).toList().length;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoListState = ref.watch(todoListProvider);

    // without provider we can calculate the computed states.
    final activeTodos = getTodoCount(todoListState.todos);

    if (todoListState.status == TodoListStatus.loading) {
      context.loaderOverlay.show();
    } else {
      context.loaderOverlay.hide();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "TODO",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        ),
        const SizedBox(width: 10),
        Text("($activeTodos/${todoListState.todos.length} item left)"),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.sunny),
          onPressed: () {
            ref.read(themeProvider.notifier).toggleTheme();
          },
        ),
        const SizedBox(width: 10),
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            ref.read(todoListProvider.notifier).getTodos();
          },
        ),
      ],
    );
  }
}
