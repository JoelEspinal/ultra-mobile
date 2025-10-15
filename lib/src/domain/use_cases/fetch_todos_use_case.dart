import 'package:dartz/dartz.dart';
import 'package:ultra_mobile/src/data/network/todos_api/models/todo.dart';

import '../failures/failure.dart';

class FetchTodosUseCase {
  // required api repository remote api

  Future<Either<Failure, List<Todo>>> execute() async {
    // Implementation goes here
    return Right([]);
  }
}
