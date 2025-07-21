import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/2-async-enum/pages/provider/search/search_provider.dart';
import 'package:todo_riverpod/2-async-enum/utils/debounce.dart';

class SearchTodo extends ConsumerStatefulWidget {
  const SearchTodo({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchTodoState();
}

class _SearchTodoState extends ConsumerState<SearchTodo> {
  final debounce = Debounce(ms: 1000);

  @override
  void dispose() {
    debounce.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(labelText: 'Search Todos', filled: true),
      onChanged: (String? searchTerm) {
        if (searchTerm != null) {
          debounce.run(() {
            ref.watch(searchProvider.notifier).setSearch(searchTerm.trim());
          });
        }
      },
    );
  }
}
