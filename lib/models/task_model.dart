class Task {
  String? id;
  String? title;
  DateTime? duedate;

  Task({required this.id, required this.title, required this.duedate});

  Map<String, dynamic> toMap() =>
      {'id': id, 'title': title, 'duedate': duedate!.toIso8601String()};

  factory Task.fromMap(Map<String, dynamic> taskdata) => Task(
      id: taskdata['id'],
      duedate: DateTime.parse(taskdata['duedate']),
      title: taskdata['title']);
}
