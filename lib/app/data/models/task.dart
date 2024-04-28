class Task {
  Task({
    required this.todos,
  });
  late final List<Todos> todos;

  Task.fromJson(Map<String, dynamic> json) {
    todos = List.from(json['todos']).map((e) => Todos.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['todos'] = todos.map((e) => e.toJson()).toList();

    return _data;
  }
}

class Todos {
  Todos({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });
  late final int id;
  late String todo;
  late bool completed;
  late final int userId;

  Todos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    todo = json['todo'];
    completed = json['completed'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['todo'] = todo;
    _data['completed'] = completed;
    _data['userId'] = userId;
    return _data;
  }
}
