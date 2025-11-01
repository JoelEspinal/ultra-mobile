import 'package:dartz/dartz.dart';

import '../../../data/database/hive/models/todo_model.dart';
import '../../failures/failure.dart';
import '../../repositories/local_todo_repository.dart';

class SaveTodoListUseCase {
  final LocalPersistenceRepository localPersistenceRepository;

  SaveTodoListUseCase({required this.localPersistenceRepository});

  Future<Either<Failure, Unit>> execute(List<Todo> todoModelList) async {
    await localPersistenceRepository.saveAll(todoModelList);
    return Future.value(Right(unit));
  }
}
