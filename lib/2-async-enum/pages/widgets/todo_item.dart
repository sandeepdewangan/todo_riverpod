import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/2-async-enum/models/todo_model.dart';
import 'package:todo_riverpod/2-async-enum/pages/provider/todo_items/todo_items_provider.dart';
import 'package:todo_riverpod/2-async-enum/pages/provider/todo_list/todo_list_provider.dart';

class TodoItem extends ConsumerWidget {
  const TodoItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(todoItemsProvider);

    print("TODO Item");
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return EditDialog(todo: todo);
          },
        );
      },
      title: Text(todo.desc), // Replace with your todo item data
      leading: Checkbox(
        value: todo.isCompleted,
        onChanged: (bool? checked) {
          ref.read(todoListProvider.notifier).toggleTodo(todo.id);
        },
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          // Handle delete action
          ref.read(todoListProvider.notifier).removeTodo(todo.id);
        },
      ),
    );
  }
}

// Edit dialog for editing todo items
class EditDialog extends ConsumerStatefulWidget {
  final Todo todo;
  const EditDialog({super.key, required this.todo});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditDialogState();
}

class _EditDialogState extends ConsumerState<EditDialog> {
  final _controller = TextEditingController();
  bool error = false;

  @override
  void initState() {
    _controller.text = widget.todo.desc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Todo'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: InputDecoration(
          errorText: error ? 'Description cannot be empty' : null,
          hintText: 'Enter todo description',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            error = _controller.text.trim().isEmpty ? true : false;

            if (error) {
              setState(() {});
            } else {
              ref
                  .read(todoListProvider.notifier)
                  .editTodo(widget.todo.id, _controller.text.trim());
              Navigator.pop(context);
            }
          },
          child: Text('Edit'),
        ),
      ],
    );
  }
}
