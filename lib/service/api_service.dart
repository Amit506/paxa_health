import 'package:paxa_health/model/todo.dart';
import 'package:paxa_health/model/user.dart';
import 'package:paxa_health/service/base_network.dart';

class ApiService extends BaseNetworkService {
  Future<User?> login(String username, String password) async {
    final res = await post('https://dummyjson.com/auth/login',
        data: {'username': username, 'password': password});
    if (res != null && res.isSuccessful) {
      return User.fromMap(res.data);
    }
  }

  Future<Todo?> addTodo(Todo todo) async {
    final res =
        await post('https://dummyjson.com/todos/add', data: todo.toMap());
    if (res != null && res.isSuccessful) {
      return Todo.fromMap(res.data);
    }
  }

  Future<List<Todo>?> getTodo(int userId) async {
    final res = await get('https://dummyjson.com/todos/user/$userId');
    if (res != null && res.isSuccessful) {
      if (res != null && res.isSuccessful) {
        return (res.data['todos'] as List).map((e) => Todo.fromMap(e)).toList();
      }
    }
  }
}
