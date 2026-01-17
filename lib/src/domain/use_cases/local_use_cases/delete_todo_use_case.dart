import 'package:dartz/dartz.dart';

import '../../../common/failures/failure.dart';
import '../../repositories/local_todo_repository.dart'
    show LocalPersistenceRepository;

class DeleteTodoUseCase {
  final LocalPersistenceRepository localPersistenceRepository;

  DeleteTodoUseCase({
    required this.localPersistenceRepository,
  });

  Future<Either<Failure, void>> execute(int id) async {
    try {
      final todo = await localPersistenceRepository.getTodo(id);

      if (todo == null) {
        return Left(CannotUpdateNullValueFailure("todo is null"));
      }

      await localPersistenceRepository.deleteTodo(id);

      return Future.value(Right(unit));
    } catch (e) {
      return Left(UnablToFindKeyFailire('error: $e'));
    }
  }
}
