import 'package:dartz/dartz.dart';

import '../../../data/database/hive/models/todo.dart';
import '../../../common/failures/failure.dart';
import '../../repositories/local_todo_repository.dart';

class SaveTodoListUseCase {
  final LocalPersistenceRepository localPersistenceRepository;

  SaveTodoListUseCase({required this.localPersistenceRepository});

  Future<Either<Failure, Unit>> execute(List<Todo> todoModelList) async {
    await localPersistenceRepository.addAll(todoModelList);
    return Future.value(Right(unit));
  }
}
