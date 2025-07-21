import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/2-async-enum/pages/provider/filter_todo/filter_todo_provider.dart';
import 'package:todo_riverpod/2-async-enum/pages/provider/todo_items/todo_items_provider.dart';
import 'package:todo_riverpod/2-async-enum/pages/provider/todo_list/todo_list_provider.dart';
import 'package:todo_riverpod/2-async-enum/pages/provider/todo_list/todo_list_status.dart';
import 'package:todo_riverpod/2-async-enum/pages/widgets/todo_item.dart';

class ShowTodos extends ConsumerStatefulWidget {
  const ShowTodos({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShowTodosState();
}

class _ShowTodosState extends ConsumerState<ShowTodos> {
  // To limit the dependency on the state of the widget,
  // we can use a variable to store the previous todos widget.
  // This way, we can avoid rebuilding the entire list when the state changes,
  Widget prevTodosWidget = const SizedBox.shrink();

  @override
  void initState() {
    super.initState();
    // Fetech the Todos when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(todoListProvider.notifier).getTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    // if error occurs while fetching the todos, show a snackbar
    ref.listen<TodoListState>(todoListProvider, (prev, next) {
      if (next.status == TodoListStatus.failure) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(next.errorMessage ?? 'Failed to load todos'),
            );
          },
        );
      }
    });

    final todoListState = ref.watch(todoListProvider);
    switch (todoListState.status) {
      case TodoListStatus.initial:
        return const SizedBox.shrink();
      case TodoListStatus.loading:
        return prevTodosWidget;
      // return const Center(child: CircularProgressIndicator());
      // This case is when the error occurs fetching todos with empty todos
      // In this case we show an error message in the center of the screen
      // In other cases we will show the previous todos with error in snackbar
      case TodoListStatus.failure when prevTodosWidget is SizedBox:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.red, size: 48),
              SizedBox(height: 8),
              Text(todoListState.errorMessage, style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  await ref.read(todoListProvider.notifier).getTodos();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      // Fallthrough to the success case
      case TodoListStatus.failure:
      case TodoListStatus.success:
        final filteredTodos = ref.watch(filteredTodosProvider);

        prevTodosWidget = ListView.builder(
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
        return prevTodosWidget;
    }
  }
}
