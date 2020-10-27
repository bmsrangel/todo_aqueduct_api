import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../../todo_api.dart';
import '../../../entities/todo.dart';
import '../service/i_todos_service.dart';
import '../view_models/todo_input_model.dart';
import 'models/todo_request_model.dart';

@Injectable()
class TodosController extends ResourceController {
  TodosController(this._service);
  final ITodosService _service;

  final Uuid uuid = Uuid();

  @Operation.get()
  Future<Response> getTodosByUser(
      @Bind.header("x-user-id") String userId) async {
    try {
      final List<Todo> todoList = await _service.getTodosByUserId(userId);
      final response =
          Response.ok(todoList.map((todo) => todo.toJson()).toList());
      return response;
    } catch (e) {
      return Response.serverError(body: {
        "message": "Erro ao carregar todos",
      });
    }
  }

  @Operation.post()
  Future<Response> newTodo(
      @Bind.body() TodoRequestModel todoRequestModel) async {
    final TodoInputModel todoInputModel = mapperNewTodo(todoRequestModel);
    try {
      await _service.newTodo(todoInputModel);
      return Response.created(todoInputModel.id, body: {
        "message": "Todo adicionado com sucesso",
      });
    } catch (e) {
      print(e);
      return Response.serverError(body: {
        "message": "Erro ao adicionar Todo",
      });
    }
  }

  @Operation.put("todoId")
  Future<Response> updateTodoId(@Bind.path("todoId") String todoId,
      @Bind.body() TodoRequestModel todoRequestModel) async {
    final TodoInputModel todoInputModel = mapper(todoRequestModel);
    try {
      await _service.updateTodo(todoId, todoInputModel);
      return Response.ok({"message": "Todo atualizado com sucesso"});
    } catch (e) {
      return Response.serverError(body: {"message": "Falha ao atualizar todo"});
    }
  }

  @Operation.delete("todoId")
  Future<Response> deleteTodo(@Bind.path("todoId") String todoId) async {
    try {
      await _service.deleteTodo(todoId);
      return Response.ok({});
    } catch (e) {
      return Response.serverError(body: {
        "message": "Erro ao excluir todo",
      });
    }
  }

  TodoInputModel mapper(TodoRequestModel todoRequestModel) {
    final TodoInputModel inputModel = TodoInputModel(
      description: todoRequestModel.description,
      dueDate: todoRequestModel.dueDate,
      completed: todoRequestModel.completed,
      userId: todoRequestModel.userId,
    );
    return inputModel;
  }

  TodoInputModel mapperNewTodo(TodoRequestModel todoRequestModel) {
    final TodoInputModel inputModel = TodoInputModel(
      id: uuid.v4(),
      description: todoRequestModel.description,
      dueDate: todoRequestModel.dueDate,
      completed: todoRequestModel.completed,
      userId: todoRequestModel.userId,
    );
    return inputModel;
  }
}
