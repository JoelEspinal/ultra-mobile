import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ultra_mobile/src/domain/entities/todo.dart';

// import '../../domain/use_cases/fetch_todo_detail_use_case.dart';
// import '../../domain/use_cases/update_todo_use_case.dart';
import '../../domain/failures/failure.dart';

import 'todo_detail_status.dart';

class TodoDetailCubit extends Cubit<TodoDetailState> {
  // final FetchTodoDetailUseCase _fetchTodoDetailUseCase;
  // final UpdateTodoUseCase _updateTodoUseCase;
  final ImagePicker _imagePicker = ImagePicker();

  TodoDetailCubit() : super(const TodoDetailState());

  // Load todo detail
  Future<void> loadTodoDetail(Todo todo) async {
    if (state.status == TodoDetailStatus.loading) return;

    emit(state.copyWith(status: TodoDetailStatus.loading));

    final result = Todo(
      id: 1,
      todo: 'Read a book',
      completed: false,
      userId: 1,
    ); //await _fetchTodoDetailUseCase.execute(todoId);

    // result.fold(
    //   (failure) {
    //     String errorMessage;
    //     if (failure is NetworkFailure) {
    //       errorMessage = 'Check your internet connection!';
    //     } else if (failure is UnauthorizedFailure) {
    //       errorMessage = 'Session expired. Please log in.';
    //     } else {
    //       errorMessage = 'An unexpected error occurred: ${failure.message}';
    //     }

    //     emit(
    //       state.copyWith(
    //         status: TodoDetailStatus.failure,
    //         errorMessage: errorMessage,
    //       ),
    //     );
    //   },
    //   (todoDetail) {
    //     emit(
    //       state.copyWith(
    //         status: TodoDetailStatus.success,
    //         todoDetail: todoDetail,
    //         errorMessage: '',
    //       ),
    //     );
    //   },

    // );

    emit(
      state.copyWith(
        status: TodoDetailStatus.success,
        todoDetail: TodoDetail(
          id: 1,
          todo: "Read 2 books",
          completed: false,
          userId: 3,
        ),
        errorMessage: '',
      ),
    );

    //    emit(
    //       state.copyWith(
    //         status: TodoDetailStatus.success,
    //         todoDetail: TodoDetail(id: 1, todo: "Read 2 books", completed: false, userId: 3),
    //         errorMessage: '',
    //       ),
    //    )
    //     );
    // );
  }

  // Update todo title
  void updateTitle(String newTitle) {
    if (state.todoDetail == null) return;

    final updatedTodo = state.todoDetail!.copyWith(todo: newTitle);
    emit(state.copyWith(todoDetail: updatedTodo));
  }

  // Toggle completed status
  void toggleCompleted() {
    if (state.todoDetail == null) return;

    final updatedTodo = state.todoDetail!.copyWith(
      completed: !state.todoDetail!.completed,
    );
    emit(state.copyWith(todoDetail: updatedTodo));
  }

  // Update description
  void updateDescription(String description) {
    if (state.todoDetail == null) return;

    final updatedTodo = state.todoDetail!.copyWith(description: description);
    emit(state.copyWith(todoDetail: updatedTodo));
  }

  // Update due date
  void updateDueDate(DateTime? dueDate) {
    if (state.todoDetail == null) return;

    final updatedTodo = state.todoDetail!.copyWith(dueDate: dueDate);
    emit(state.copyWith(todoDetail: updatedTodo));
  }

  // Update priority
  void updatePriority(Priority priority) {
    if (state.todoDetail == null) return;

    final updatedTodo = state.todoDetail!.copyWith(priority: priority);
    emit(state.copyWith(todoDetail: updatedTodo));
  }

  // Update category
  void updateCategory(String category) {
    if (state.todoDetail == null) return;

    final updatedTodo = state.todoDetail!.copyWith(category: category);
    emit(state.copyWith(todoDetail: updatedTodo));
  }

  // Toggle favorite status
  void toggleFavorite() {
    if (state.todoDetail == null) return;

    final updatedTodo = state.todoDetail!.copyWith(
      isFavorite: !state.todoDetail!.isFavorite,
    );
    emit(state.copyWith(todoDetail: updatedTodo));
  }

  // Pick image from camera
  Future<void> pickImageFromCamera() async {
    try {
      final XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (photo != null && state.todoDetail != null) {
        final updatedTodo = state.todoDetail!.copyWith(imagePath: photo.path);
        emit(state.copyWith(todoDetail: updatedTodo));
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: TodoDetailStatus.failure,
          errorMessage: 'Error accessing camera: $e',
        ),
      );
    }
  }

  // Pick image from gallery
  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null && state.todoDetail != null) {
        final updatedTodo = state.todoDetail!.copyWith(imagePath: image.path);
        emit(state.copyWith(todoDetail: updatedTodo));
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: TodoDetailStatus.failure,
          errorMessage: 'Error accessing gallery: $e',
        ),
      );
    }
  }

  // Remove attached image
  void removeImage() {
    if (state.todoDetail == null) return;

    final updatedTodo = state.todoDetail!.copyWith(imagePath: null);
    emit(state.copyWith(todoDetail: updatedTodo));
  }

  // Set reminder time
  void setReminder(DateTime? reminderTime) {
    if (state.todoDetail == null) return;

    final updatedTodo = state.todoDetail!.copyWith(reminderTime: reminderTime);
    emit(state.copyWith(todoDetail: updatedTodo));
  }

  // Save all changes to the backend
  Future<void> saveTodo() async {
    if (state.todoDetail == null) return;
    if (state.status == TodoDetailStatus.updating) return;

    emit(state.copyWith(status: TodoDetailStatus.updating));

    // final result = await _updateTodoUseCase.execute(state.todoDetail!);

    // result.fold(
    //   (failure) {
    //     String errorMessage;
    //     if (failure is NetworkFailure) {
    //       errorMessage = 'Check your internet connection!';
    //     } else if (failure is UnauthorizedFailure) {
    //       errorMessage = 'Session expired. Please log in.';
    //     } else {
    //       errorMessage = 'Failed to save changes: ${failure.message}';
    //     }

    //     emit(
    //       state.copyWith(
    //         status: TodoDetailStatus.failure,
    //         errorMessage: errorMessage,
    //       ),
    //     );
    //   },
    //   (updatedTodo) {
    //     emit(
    //       state.copyWith(
    //         status: TodoDetailStatus.success,
    //         todoDetail: updatedTodo,
    //         errorMessage: '',
    //       ),
    //     );
    //   },
    // );

    emit(
      state.copyWith(
        status: TodoDetailStatus.success,
        todoDetail: TodoDetail(
          id: 3,
          todo: "Updated todo",
          completed: true,
          userId: 3,
        ),
        errorMessage: '',
      ),
    );
  }
}
