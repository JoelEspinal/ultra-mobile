import 'package:bloc/bloc.dart';
import 'package:ultra_mobile/src/domain/use_cases/sync_todos_use_case.dart';

import 'start_up_state.dart';

// Make sure to import your repository
// import 'package:your_app/todos/repository/todo_repository.dart';

class StartupCubit extends Cubit<StartupState> {
  final SyncTodosUseCase _syncTodosUseCase;

  StartupCubit({required SyncTodosUseCase syncTodosUseCase})
      : _syncTodosUseCase = syncTodosUseCase,
        super(const StartupState());

  /// Fetches Todos from the API and syncs them into the Hive box.
  /// The state will not hold any data, only the status of the operation.
  Future<void> syncTodos() async {
    emit(state.copyWith(status: StartupStatus.loading));
    try {
      await _syncTodosUseCase.execute();

      emit(
        state.copyWith(status: StartupStatus.success),
      );
    } catch (e) {
      emit(state.copyWith(
        status: StartupStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
