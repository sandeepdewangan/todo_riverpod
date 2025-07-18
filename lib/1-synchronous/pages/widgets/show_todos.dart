import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/1-synchronous/pages/provider/filter_todo/filter_todo_provider.dart';
import 'package:todo_riverpod/1-synchronous/pages/provider/todo_items/todo_items_provider.dart';
import 'package:todo_riverpod/1-synchronous/pages/widgets/todo_item.dart';

class ShowTodos extends ConsumerWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredTodos = ref.watch(filteredTodosProvider);

    return ListView.builder(
      itemCount: filteredTodos.length, // Replace with your todo list length
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final todo = filteredTodos[index];
        // Here the problem is todo is passed, we cannot make it const.
        // The ListTile todo items builds whenever the state changes,
        // to avoid this scenarios of unnexessary rebuilds,
        // we can use ProviderScope to rebuild only the necessary widgets.
        return ProviderScope(
          overrides: [todoItemsProvider.overrideWithValue(todo)],
          // child: TodoItem(todo: todo),
          child:
              const TodoItem(), // Now we dont need to pass todo as it is provided by the ProviderScope
        );
      },
    );
  }
}
