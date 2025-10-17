import 'package:dartz/dartz.dart';
import 'package:ultra_mobile/src/domain/repositories/persistence_repository.dart';

import '../entities/todo.dart' as todo_entity;
import '../failures/failure.dart';
import '../repositories/todo_repository.dart';

class FetchTodosUseCase {
  final TodoRepository todoRepository;
  final PersistenceRepository persistenceRepository;

  FetchTodosUseCase(
      {required this.persistenceRepository, required this.todoRepository});

  Future<Either<Failure, List<todo_entity.Todo>>> execute() async {
    final todos = await todoRepository.getTodos();

    // if (todos.isRight()) {
    //   todos.fold(
    //     (l) {},
    //     (r) async {
    //       for (var todoElement in r) {
    //         todo_entity.Todo? todo =
    //             await persistenceRepository.getTodo(todoElement.id);

    //         if (todo == null) {
    //           await persistenceRepository.saveTodo(todoElement);
    //         }
    //       }
    //     },
    //   );
    // }

    // var todoList = await persistenceRepository.getTodos();
    // var leng = todoList.length;

    // if (todoList.isEmpty) return todos;

    // return Future(() => Right(todoList));

    return todos;
  }
}
