// // ========== Fetch Todo Detail Use Case ==========
// import 'package:dartz/dartz.dart';
// import '../entities/todo.dart';
// import '../failures/failure.dart';
// import '../repositories/todo_repository.dart';

// class FetchTodoDetailUseCase {
//   final TodoRepository _repository;

//   FetchTodoDetailUseCase(this._repository);

//   Future<Either<Failure, Todo>> execute(int todoId) async {
//     try {
//       return await _repository.getTodoDetail(todoId);
//     } catch (e) {
//       return Left(ServerFailure('Failed to fetch todo detail: $e'));
//     }
//   }
// }

// // ========== Update Todo Use Case ==========
// class UpdateTodoUseCase {
//   final TodoRepository _repository;

//   UpdateTodoUseCase(this._repository);

//   Future<Either<Failure, Todo>> execute(TodoDeTodotail todoDetail) async {
//     try {
//       // Validate todo before updating
//       if (todoDetail.todo.trim().isEmpty) {
//         return Left(ValidationFailure('Todo title cannot be empty'));
//       }

//       return await _repository.updateTodo(todoDetail);
//     } catch (e) {
//       return Left(ServerFailure('Failed to update todo: $e'));
//     }
//   }
// }

// // ========== Repository Interface (add these methods) ==========
// // Add these methods to your TodoRepository interface:
// abstract class TodoRepository {
//   // ... existing methods ...
  
//   Future<Either<Failure, TodoDetail>> getTodoDetail(int todoId);
//   Future<Either<Failure, TodoDetail>> updateTodo(TodoDetail todoDetail);
// }

// // ========== Data Source Implementation Example ==========
// // Add these methods to your TodoRemoteDataSource implementation:

// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
//   final http.Client client;
//   final String baseUrl = 'https://dummyjson.com/todos';

//   TodoRemoteDataSourceImpl(this.client);

//   // ... existing methods ...

//   @override
//   Future<TodoDetail> getTodoDetail(int todoId) async {
//     final response = await client.get(
//       Uri.parse('$baseUrl/$todoId'),
//       headers: {'Content-Type': 'application/json'},
//     );

//     if (response.statusCode == 200) {
//       final json = jsonDecode(response.body);
      
//       // Map API response to TodoDetail
//       // Note: API might not have all fields, so we provide defaults
//       return TodoDetail(
//         id: json['id'],
//         todo: json['todo'],
//         completed: json['completed'],
//         userId: json['userId'],
//         description: json['description'] ?? '',
//         dueDate: json['dueDate'] != null 
//             ? DateTime.parse(json['dueDate']) 
//             : null,
//         priority: _parsePriority(json['priority']),
//         category: json['category'] ?? '',
//         isFavorite: json['isFavorite'] ?? false,
//         imagePath: json['imagePath'],
//         reminderTime: json['reminderTime'] != null
//             ? DateTime.parse(json['reminderTime'])
//             : null,
//       );
//     } else if (response.statusCode == 404) {
//       throw NotFoundException('Todo not found');
//     } else if (response.statusCode == 401) {
//       throw UnauthorizedException('Unauthorized access');
//     } else {
//       throw ServerException('Server error: ${response.statusCode}');
//     }
//   }

//   @override
//   Future<TodoDetail> updateTodo(TodoDetail todoDetail) async {
//     final response = await client.put(
//       Uri.parse('$baseUrl/${todoDetail.id}'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'todo': todoDetail.todo,
//         'completed': todoDetail.completed,
//         'description': todoDetail.description,
//         'dueDate': todoDetail.dueDate?.toIso8601String(),
//         'priority': todoDetail.priority.name,
//         'category': todoDetail.category,
//         'isFavorite': todoDetail.isFavorite,
//         'imagePath': todoDetail.imagePath,
//         'reminderTime': todoDetail.reminderTime?.toIso8601String(),
//       }),
//     );

//     if (response.statusCode == 200) {
//       final json = jsonDecode(response.body);
      
//       // Return the updated todo
//       return TodoDetail(
//         id: json['id'],
//         todo: json['todo'],
//         completed: json['completed'],
//         userId: json['userId'],
//         description: json['description'] ?? todoDetail.description,
//         dueDate: todoDetail.dueDate,
//         priority: todoDetail.priority,
//         category: todoDetail.category,
//         isFavorite: todoDetail.isFavorite,
//         imagePath: todoDetail.imagePath,
//         reminderTime: todoDetail.reminderTime,
//       );
//     } else if (response.statusCode == 401) {
//       throw UnauthorizedException('Unauthorized access');
//     } else {
//       throw ServerException('Failed to update todo: ${response.statusCode}');
//     }
//   }

//   Priority _parsePriority(dynamic priority) {
//     if (priority == null) return Priority.medium;
    
//     switch (priority.toString().toLowerCase()) {
//       case 'high':
//         return Priority.high;
//       case 'low':
//         return Priority.low;
//       default:
//         return Priority.medium;
//     }
//   }
// }

// // ========== Repository Implementation ==========
// class TodoRepositoryImpl implements TodoRepository {
//   final TodoRemoteDataSource remoteDataSource;

//   TodoRepositoryImpl(this.remoteDataSource);

//   // ... existing methods ...

//   @override
//   Future<Either<Failure, TodoDetail>> getTodoDetail(int todoId) async {
//     try {
//       final todoDetail = await remoteDataSource.getTodoDetail(todoId);
//       return Right(todoDetail);
//     } on NotFoundException {
//       return Left(NotFoundFailure('Todo not found'));
//     } on UnauthorizedException {
//       return Left(UnauthorizedFailure('Unauthorized access'));
//     } on NetworkException {
//       return Left(NetworkFailure('No internet connection'));
//     } catch (e) {
//       return Left(ServerFailure('Unexpected error: $e'));
//     }
//   }

//   @override
//   Future<Either<Failure, TodoDetail>> updateTodo(TodoDetail todoDetail) async {
//     try {
//       final updatedTodo = await remoteDataSource.updateTodo(todoDetail);
//       return Right(updatedTodo);
//     } on UnauthorizedException {
//       return Left(UnauthorizedFailure('Unauthorized access'));
//     } on NetworkException {
//       return Left(NetworkFailure('No internet connection'));
//     } catch (e) {
//       return Left(ServerFailure('Failed to update todo: $e'));
//     }
//   }
// }