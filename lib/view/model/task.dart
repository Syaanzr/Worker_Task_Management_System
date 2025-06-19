class Task {
  final int id;
  final String title;
  final String description;
  final String dateAssigned;
  final String dueDate;
  final String status;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dateAssigned,
    required this.dueDate,
    required this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] ?? 0,
      title: json['title'] ?? '', 
      description: json['description'] ?? '', 
      dateAssigned: json['date_assigned'] ?? '', 
      dueDate: json['due_date'] ?? '',
      status: json['status']?? '', 
      );
  }
}