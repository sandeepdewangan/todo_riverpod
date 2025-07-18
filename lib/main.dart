import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/1-synchronous/pages/provider/theme/theme_provider.dart';
import 'package:todo_riverpod/1-synchronous/pages/todo_page.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: currentTheme == AppTheme.light
          ? ThemeData.light(useMaterial3: true)
          : ThemeData.dark(useMaterial3: true),
      home: const TodoPage(),
    );
  }
}
