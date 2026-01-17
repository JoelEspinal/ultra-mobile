import 'package:dartz/dartz.dart';
import '../../../common/failures/failure.dart';

import '../../../data/database/hive/models/todo.dart';
import '../../repositories/local_todo_repository.dart';

class ToggleFavoriteTodoUseCase {
  final LocalPersistenceRepository localPersistenceRepository;

  ToggleFavoriteTodoUseCase({
    required this.localPersistenceRepository,
  });

  Future<Either<Failure, Unit>> execute(int id) async {
    Todo? currentTodo = await localPersistenceRepository.getTodo(id);
    if (currentTodo == null) return Left(UnableToFindTodoFailure("$id"));

    Todo? modelTodo = await localPersistenceRepository.getTodo(id);
    if (modelTodo == null) throw UnableToFindTodoFailure("$id");

    Todo resultTodo =
        await localPersistenceRepository.toggleFavorite(modelTodo);
    await localPersistenceRepository.updateTodo(resultTodo);

    return Future.value(Right(unit));
  }
}
