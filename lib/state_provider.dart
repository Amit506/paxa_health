import 'package:flutter/foundation.dart';
import 'package:paxa_health/model/todo.dart';
import 'package:paxa_health/model/user.dart';
import 'package:paxa_health/service/api_service.dart';

class StateProvider extends ChangeNotifier {
  ApiService _apiService = ApiService();
  User? user;
  setUser(User user) {
    user = user;
  }

  Future<Todo?> addTask(
      String name, String hour, bool today, String image) async {
    final todo = Todo(
        todo: SubTodo(name: name, Hour: hour, today: today, img: image),
        completed: false,
        userId: user?.id ?? 2);
    final res = await _apiService.addTodo(todo);
    if (res != null) {
      todos.add(res);
      notifyListeners();
    }
    // await getTasks();
    return res;
  }

  List<Todo> todos = [
    Todo(
        todo: SubTodo(
            name: 'dwhfbwh  ewfbwhjfbw f qehjqfbqjhfb  qehjfbef',
            Hour: '12:00 AM',
            today: true),
        completed: false,
        userId: 2),
    Todo(
        todo: SubTodo(
            name: 'dwhfbwh  ewfbwhjfbw f qehjqfbqjhfb  qehjfbef',
            Hour: '12:00 AM',
            today: true),
        completed: true,
        userId: 2),
    Todo(
        todo: SubTodo(
            name: 'dwhfbwh  ewfbwhjfbw f qehjqfbqjhfb  qehjfbef',
            Hour: '12:00 AM',
            today: false),
        completed: false,
        userId: 2)
  ];
  getTasks() async {
    // final value = await _apiService.getTodo(user?.id ?? 2);
    // if (value != null) {
    //   todos = value;
    // }
    notifyListeners();
  }
}
