import 'package:aqueduct/aqueduct.dart';

class TodoRequestModel extends Serializable {
  TodoRequestModel({
    this.description,
    this.dueDate,
    this.completed = false,
    this.userId,
  });

  String description;
  String dueDate;
  bool completed;
  String userId;

  @override
  Map<String, dynamic> asMap() {
    return {
      "description": description,
      "dueDate": dueDate,
      "completed": completed,
      "userId": userId,
    };
  }

  @override
  void readFromMap(Map<String, dynamic> object) {
    description = object["description"] as String;
    dueDate = object["dueDate"] as String;
    completed = object["completed"] as bool ?? false;
    userId = object["userId"] as String;
  }
}
