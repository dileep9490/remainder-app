class Task {
  int? id;
  String title;
  DateTime duedate;
  bool isScheduled;

  Task({required this.title, required this.duedate, this.isScheduled = false});
  Task.withid(
      {required this.id,
      required this.title,
      required this.duedate,
      required this.isScheduled});

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'duedate': duedate.toIso8601String(),
        'isScheduled': isScheduled ? 1 : 0,
      };

  factory Task.fromMap(Map<String, dynamic> taskdata) => Task.withid(
      id: taskdata['id'],
      duedate: DateTime.parse(taskdata['duedate']),
      title: taskdata['title'],
      isScheduled: taskdata['isScheduled'] == 1 ? true : false);
}
