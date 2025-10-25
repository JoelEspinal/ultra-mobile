// import 'dart:async';

// import 'package:dartz/dartz.dart';
// import '../failures/failure.dart';
// import '../repositories/persistence_repository.dart';

// import '../../data/network/error_handler.dart';
// import '../entities/todo.dart';

// class FetchTodoDetailUseCase {
//   final PersistenceRepository persistenceRepositoriy;

//   FetchTodoDetailUseCase(this.persistenceRepositoriy);

//   Future<Either<Failure, Todo?>> execute(int todoId) async {
//     try {
//       final todoDetail = await persistenceRepositoriy.getTodo(todoId);

//       return Right(todoDetail);
//     } catch (e) {
//       return Future.value(Left(mapExceptionToFailure(e)));
//     }
//   }
// }
