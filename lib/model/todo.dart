import 'dart:convert';

class Todo {
  final int? id;
  final SubTodo todo;
  final bool completed;
  final int userId;
  Todo({
    this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  Todo copyWith({
    int? id,
    SubTodo? todo,
    bool? completed,
    int? userId,
  }) {
    return Todo(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'todo': todo.toMap(),
      'completed': completed,
      'userId': userId,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id']?.toInt() ?? 0,
      todo: SubTodo.fromMap(map['todo']),
      completed: map['completed'] ?? false,
      userId: map['userId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Todo(id: $id, todo: $todo, completed: $completed, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todo &&
        other.id == id &&
        other.todo == todo &&
        other.completed == completed &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ todo.hashCode ^ completed.hashCode ^ userId.hashCode;
  }
}

class SubTodo {
  final String name;
  final String Hour;
  final bool today;
  final String? img;
  SubTodo({
    required this.name,
    required this.Hour,
    required this.today,
    this.img,
  });

  SubTodo copyWith({
    String? name,
    String? Hour,
    bool? today,
    String? img,
  }) {
    return SubTodo(
      name: name ?? this.name,
      Hour: Hour ?? this.Hour,
      today: today ?? this.today,
      img: img ?? this.img,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'Hour': Hour,
      'today': today,
      'img': img,
    };
  }

  factory SubTodo.fromMap(Map<String, dynamic> map) {
    return SubTodo(
      name: map['name'] ?? '',
      Hour: map['Hour'] ?? '',
      today: map['today'] ?? false,
      img: map['img'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SubTodo.fromJson(String source) =>
      SubTodo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Todo(name: $name, Hour: $Hour, today: $today, img: $img)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubTodo &&
        other.name == name &&
        other.Hour == Hour &&
        other.today == today &&
        other.img == img;
  }

  @override
  int get hashCode {
    return name.hashCode ^ Hour.hashCode ^ today.hashCode ^ img.hashCode;
  }
}
