import '../../../entities/todo.dart';
import '../view_models/todo_input_model.dart';

abstract class ITodosService {
  Future<List<Todo>> getTodosByUserId(String userId);
  Future<void> newTodo(TodoInputModel todoInputModel);
  Future<void> updateTodo(String todoId, TodoInputModel todoInputModel);
  Future<void> deleteTodo(String todoId);
}
