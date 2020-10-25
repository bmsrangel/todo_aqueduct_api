import 'package:todo_api/app/entities/todo.dart';
import 'package:todo_api/app/modules/todos/view_models/todo_input_model.dart';

abstract class ITodosRepository {
  Future<List<Todo>> getTodosByUserId(String userId);
  Future<void> newTodo(TodoInputModel todoInputModel);
  Future<void> updateTodo(String todoId, TodoInputModel todoInputModel);
  Future<void> deleteTodo(String todoId);
}
