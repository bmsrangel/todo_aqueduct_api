class TodoInputModel {
  TodoInputModel({
    this.id,
    this.description,
    this.dueDate,
    this.completed = false,
    this.userId,
  });

  final String id;
  final String description;
  final String dueDate;
  final bool completed;
  final String userId;
}
