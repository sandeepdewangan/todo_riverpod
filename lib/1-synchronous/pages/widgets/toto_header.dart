import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/1-synchronous/pages/provider/active_todo_count/active_todo_count_provider.dart';
import 'package:todo_riverpod/1-synchronous/pages/provider/theme/theme_provider.dart';
import 'package:todo_riverpod/1-synchronous/pages/provider/todo_list/todo_list_provider.dart';

class TodoHeader extends ConsumerWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTodos = ref.watch(activeTodoCountProvider);
    final todos = ref.watch(todoListProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "TODO",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
        ),
        const SizedBox(width: 10),
        Text("($activeTodos/${todos.length} item left)"),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.sunny),
          onPressed: () {
            ref.read(themeProvider.notifier).toggleTheme();
          },
        ),
      ],
    );
  }
}
