import 'package:injectable/injectable.dart';

import '../../../entities/todo.dart';
import '../data/i_todos_repository.dart';
import '../view_models/todo_input_model.dart';
import 'i_todos_service.dart';

@LazySingleton(as: ITodosService)
class TodosService implements ITodosService {
  TodosService(this._repository);
  final ITodosRepository _repository;

  @override
  Future<List<Todo>> getTodosByUserId(String userId) {
    return _repository.getTodosByUserId(userId);
  }

  @override
  Future<void> newTodo(TodoInputModel todoInputModel) {
    return _repository.newTodo(todoInputModel);
  }

  @override
  Future<void> deleteTodo(String todoId) {
    return _repository.deleteTodo(todoId);
  }

  @override
  Future<void> updateTodo(String todoId, TodoInputModel todoInputModel) {
    return _repository.updateTodo(todoId, todoInputModel);
  }
}
