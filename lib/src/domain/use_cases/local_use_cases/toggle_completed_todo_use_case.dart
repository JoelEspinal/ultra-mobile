import 'package:dartz/dartz.dart';

import '../../../common/failures/failure.dart';
import '../../repositories/local_todo_repository.dart';

class ToggleCompleteTodoUseCase {
  final LocalPersistenceRepository localPersistenceRepository;

  ToggleCompleteTodoUseCase({required this.localPersistenceRepository});

  Future<Either<Failure, void>> execute(int id) async {
    try {
      final existingTodo = await localPersistenceRepository.getTodo(id);
      if (existingTodo == null) {
        return Left(UnablToFindTodoFailire("$id"));
      }

      final todoResult =
          await localPersistenceRepository.toggleCompleted(existingTodo);
      await localPersistenceRepository.updateTodo(todoResult);

      return Future.value(Right(unit));
    } catch (e) {
      return Left(CannotUpdateToggleCompleteFailure("$e"));
    }
  }
}
