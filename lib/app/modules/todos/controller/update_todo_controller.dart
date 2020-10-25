import 'package:injectable/injectable.dart';

import '../../../../todo_api.dart';
import '../service/i_todos_service.dart';
import '../view_models/todo_input_model.dart';
import 'models/todo_request_model.dart';

@Injectable()
class UpdateTodoController extends ResourceController {
  UpdateTodoController(this._service);
  final ITodosService _service;

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

  TodoInputModel mapper(TodoRequestModel todoRequestModel) {
    final TodoInputModel inputModel = TodoInputModel(
      description: todoRequestModel.description,
      dueDate: todoRequestModel.dueDate,
      completed: todoRequestModel.completed,
      userId: todoRequestModel.userId,
    );
    return inputModel;
  }
}
