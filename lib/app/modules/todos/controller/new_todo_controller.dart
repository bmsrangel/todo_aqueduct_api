import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../../todo_api.dart';
import '../service/i_todos_service.dart';
import '../view_models/todo_input_model.dart';
import 'models/todo_request_model.dart';

@Injectable()
class NewTodoController extends ResourceController {
  NewTodoController(this._service);
  final ITodosService _service;
  final Uuid uuid = Uuid();

  @Operation.post()
  Future<Response> newTodo(
      @Bind.body() TodoRequestModel todoRequestModel) async {
    final TodoInputModel todoInputModel = mapper(todoRequestModel);
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

  TodoInputModel mapper(TodoRequestModel todoRequestModel) {
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