import 'package:bloc/bloc.dart';

import '../../domain/use_cases/fetch_todos_use_case.dart';
import '../../domain/failures/failure.dart';

import 'todos_state.dart';

// The Cubit acts as the ViewModel
class TodosCubit extends Cubit<TodosState> {
  final FetchTodosUseCase _fetchTodosUseCase;

  TodosCubit(this._fetchTodosUseCase) : super(const TodosState());

  // 2. Event Handler: This method is called by the UI (the View).
  Future<void> loadTodos() async {
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
            todos: todos,
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

    // You would typically call a Use Case here to update the remote API
    // _updateTodoStatusUseCase.call(todoId, updatedTodos.firstWhere(...).isCompleted);
  }
}
