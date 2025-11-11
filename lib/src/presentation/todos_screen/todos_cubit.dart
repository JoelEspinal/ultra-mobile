import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import '../../common/failures/failure.dart';
import '../../domain/use_cases/local_use_cases/delete_todo_use_case.dart';
import '../../domain/use_cases/local_use_cases/fetch_todo_list_from_hive_use_case.dart';
import '../../domain/use_cases/local_use_cases/toggle_completed_todo_use_case.dart';
import '../../domain/use_cases/local_use_cases/toggle_favorite_todo_use_case.dart';
import 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  final FetchLocalTodoUseCase fetchLocalTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;
  final ToggleFavoriteTodoUseCase toggleFavoriteTodoUseCase;
  final ToggleCompleteTodoUseCase toggleCompleteTodoUseCase;

  TodosCubit({
    required this.fetchLocalTodoUseCase,
    required this.deleteTodoUseCase,
    required this.toggleFavoriteTodoUseCase,
    required this.toggleCompleteTodoUseCase,
  }) : super(const TodosState());

  // 2. Event Handler: This method is called by the UI (the View).
  Future<void> loadTodos([String? filter]) async {
    emit(
      state.copyWith(
        status: TodoStatus.initial,
        errorMessage: '',
      ),
    );

    // if (state.status == TodoStatus.loading) return;

    // Emit the Loading state to update the UI
    emit(state.copyWith(status: TodoStatus.loading));

    // 3. Call Business Logic: Execute the Use Case
    final todoList = await fetchLocalTodoUseCase.execute();

    // 4. Process Result: Use the 'fold' method from dartz (Either)
    todoList.fold(
      // Left side: Failure
      (failure) {
        // Map the abstract Domain Failure into a Presentation error message
        String errorMessage;
        if (failure is NetworkFailure) {
          errorMessage = 'Check your internet connection!';
        } else if (failure is UnauthorizedFailure) {
          errorMessage = 'Session expired. Please log in.';
        } else {
          errorMessage = 'An unexpected error occurred: ${failure.message}';
        }

        // Emit the Failure state
        emit(
          state.copyWith(
            status: TodoStatus.failure,
            errorMessage: errorMessage,
          ),
        );
      },

      (resultTodos) {
        // final resultList = resultTodos
        //     .map((model) => todo_entity.Todo(
        //         id: model.id,
        //         todo: model.todo,
        //         completed: model.completed,
        //         userId: model.userId))
        //     .toList();
        // final resultList = todo_model.Todo.toEntityList(resultTodos.cast());

        emit(
          state.copyWith(
            status: TodoStatus.success,
            todos: resultTodos,
            //resultTodos.map((todoModel) => todoModel.toEntity()).toList()
            // as List<todo_entity.Todo>?,

            // List<Todo>.from(
            //   resultTodos,
            // ),

            // (filter != null && filter.isNotEmpty)
            //     ? todos
            //         .where(
            //           (todo) => todo.todo.toLowerCase().contains(
            //                 filter.toLowerCase(),
            //               ),
            //         )
            //         .toList()

            // : todos,
            errorMessage: '',
          ),
        );
      },
    );
  }

  // Toggle favorite status
  void toggleFavorite(int todoId) async {
    emit(state.copyWith(
      status: TodoStatus.loading,
    ));

    final toggleResult = await toggleFavoriteTodoUseCase.execute(todoId);
    toggleResult.fold(
      (l) {
        emit(state.copyWith(
            status: TodoStatus.failure, errorMessage: l.message));
      },
      (r) async {
        final resulTodos = await fetchLocalTodoUseCase.execute();
        resulTodos.fold(
          (left) => Left(left),
          (right) {
            emit(
              state.copyWith(
                status: TodoStatus.success,
                todos: right,
              ),
            );
          },
        );
      },
    );
  }

  void toggleCompleted(int todoId) async {
    emit(state.copyWith(status: TodoStatus.loading));
    final result = await toggleCompleteTodoUseCase.execute(todoId);
    result.fold(
      (l) {
        emit(state.copyWith(
            status: TodoStatus.failure, errorMessage: l.message));
      },
      (r) async {
        final resulTodos = await fetchLocalTodoUseCase.execute();
        resulTodos.fold(
          (left) => Left(left),
          (right) {
            emit(
              state.copyWith(
                status: TodoStatus.success,
                todos: right,
              ),
            );
          },
        );
      },
    );
  }

  void deleteTodo(int todoId) async {
    if (state.status == TodoStatus.loading) return;

    emit(state.copyWith(status: TodoStatus.loading));

    final result = await deleteTodoUseCase.execute(todoId);

    result.fold(
      (failure) {
        String errorMessage;
        if (failure is NetworkFailure) {
          errorMessage = 'Check your internet connection!';
        } else if (failure is UnauthorizedFailure) {
          errorMessage = 'Session expired. Please log in.';
        } else {
          errorMessage = 'An unexpected error occurred: ${failure.message}';
        }

        // Emit the Failure state
        emit(
          state.copyWith(
            status: TodoStatus.failure,
            errorMessage: errorMessage,
          ),
        );
      },
      (todo) {
        // On success, remove the todo from the list
        final updatedTodos =
            state.todos.where((todo) => todo.id != todoId).toList();

        emit(
          state.copyWith(
            status: TodoStatus.success,
            todos: updatedTodos,
            errorMessage: '',
          ),
        );
      },
    );
  }

  // Example of another method to handle UI actions
  void toggleTodoStatus(int todoId) {
    final updatedTodos = state.todos.map((todo) {
      return todo.id == todoId
          ? todo.copyWith(completed: !todo.completed)
          : todo;
    }).toList();

    // Emit a new success state immediately for optimistic UI update
    emit(state.copyWith(todos: updatedTodos));

    // Pending implementation of the update use case

    // You would typically call a Use Case here to update the remote API
    // _updateTodoStatusUseCase.call(todoId, updatedTodos.firstWhere(...).isCompleted);
  }
}
