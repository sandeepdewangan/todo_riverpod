import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod/2-async-enum/repo/todos_repo.dart';

part 'todo_repo_provider.g.dart';

// By using Riverpod, we can create a provider for the TodosRepo.
// This allows us to easily switch between different implementations of the repository,
// such as a real repository or a fake one for testing purposes.
@riverpod
TodosRepo todoRepo(ref) {
  throw UnimplementedError();
}
