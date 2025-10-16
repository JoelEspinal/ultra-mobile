import '../api_client.dart';
import '../constant.dart';
import '../models/todo.dart';
import '../models/todo_response.dart';

class TodoService {
  final ApiClient apiClient;

  TodoService({required this.apiClient});

  Future<Todo> fetchTodo(int id) async {
    final request = "${Constant.todosEndpoint}/$id";
    final response = await apiClient.dio.get(request);
    return Todo.fromJson(response.data);
  }

  Future<TodosResponse> fetchTodos() async {
    final response = await apiClient.dio.get(Constant.todosEndpoint);
    return TodosResponse.fromJson(response.data);
  }

  Future<TodosResponse> paginateTodos({int limit = 20, int skip = 0}) async {
    final request = "${Constant.baseUrl}?${Constant.limit}=$limit&skip=$skip";
    final response = await apiClient.dio.get(request);
    return TodosResponse.fromJson(response.data);
  }

  Future<String> createTodo(Todo todo) async {
    await Future.delayed(const Duration(seconds: 2));
    return "Todo Created";
  }

  Future<String> editTodo(Todo todo) async {
    await Future.delayed(const Duration(seconds: 2));
    return "Todo Edited";
  }

  Future<Todo?> deleteTodo(int id) async {
    final request = "${Constant.baseUrl}${Constant.todosEndpoint}/$id";
    final response = await apiClient.dio.delete(request);
    return Todo.fromJson(response.data);
  }
}
