import 'package:bloc/bloc.dart';

import '../../domain/use_cases/fetch_todos_use_case.dart';
import '../../domain/use_cases/delete_todo_use_case.dart';
import '../../domain/failures/failure.dart';

import 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  final FetchTodosUseCase _fetchTodosUseCase;
  final DeleteTodoUseCase _deleteTodoUseCase;

  TodosCubit(this._fetchTodosUseCase, this._deleteTodoUseCase)
    : super(const TodosState());

  // 2. Event Handler: This method is called by the UI (the View).
  Future<void> loadTodos([String? filter]) async {
    if (state.status == TodoStatus.loading) return;

    // Emit the Loading state to update the UI
    emit(state.copyWith(status: TodoStatus.loading));

    // 3. Call Business Logic: Execute the Use Case
    final result = await _fetchTodosUseCase.execute();

    // 4. Process Result: Use the 'fold' method from dartz (Either)
    result.fold(
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
      (todos) {
        emit(
          state.copyWith(
            status: TodoStatus.success,
            todos: (filter != null && filter.isNotEmpty)
                ? todos
                      .where(
                        (todo) => todo.todo.toLowerCase().contains(
                          filter.toLowerCase(),
                        ),
                      )
                      .toList()
                : todos,
            errorMessage: '',
          ),
        );
      },
    );
  }

  void deleteTodo(int todoId) async {
    if (state.status == TodoStatus.loading) return;

    emit(state.copyWith(status: TodoStatus.loading));
    final result = await _deleteTodoUseCase.execute(todoId);

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
        final updatedTodos = state.todos
            .where((todo) => todo.id != todoId)
            .toList();

        emit(
          state.copyWith(
            status: TodoStatus.success,
            todos: updatedTodos,
            errorMessage: '',
          ),
        );
      },
    );
    final updatedTodos = state.todos
        .where((todo) => todo.id != todoId)
        .toList();

    // Emit a new success state immediately for optimistic UI update
    emit(state.copyWith(todos: updatedTodos));
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
