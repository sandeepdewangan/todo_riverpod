import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/2-async-enum/models/todo_model.dart';
import 'package:todo_riverpod/2-async-enum/pages/provider/todo_filter/todo_filter_provider.dart';

class FilterTodo extends StatelessWidget {
  const FilterTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FilterButtom(filter: Filter.all),
        FilterButtom(filter: Filter.active),
        FilterButtom(filter: Filter.completed),
      ],
    );
  }
}

class FilterButtom extends ConsumerWidget {
  final Filter filter;
  const FilterButtom({super.key, required this.filter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilter = ref.watch(todoFilterProvider);

    return TextButton(
      onPressed: () {
        ref.read(todoFilterProvider.notifier).changeFilter(filter);
      },
      child: Text(
        filter.name.toUpperCase(),
        style: TextStyle(
          color: currentFilter == filter ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}
