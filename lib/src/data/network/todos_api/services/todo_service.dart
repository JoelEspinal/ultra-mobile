import 'package:ultra_mobile/src/data/network/todos_api/api_client.dart';
import 'package:ultra_mobile/src/data/network/todos_api/constant.dart';
import 'package:ultra_mobile/src/data/network/todos_api/models/todo_response.dart';

class TodoService {
  final ApiClient apiClient;

  TodoService({required this.apiClient});

  Future<TodosResponse> fetchTodos() async {
    final response = await apiClient.dio.get(Constant.todosEndpoint);
    return TodosResponse.fromJson(response.data);
  }

  Future<TodosResponse> paginateTodos({int limit = 20, int skip = 0}) async {
    final request = "${Constant.baseUrl}?${Constant.limit}=$limit&skip=$skip";
    final response = await apiClient.dio.get(request);
    return TodosResponse.fromJson(response.data);
  }
}
