import 'package:injectable/injectable.dart';
import 'package:todo_api/app/modules/todos/service/i_todos_service.dart';

import '../../../../todo_api.dart';

@Injectable()
class DeleteTodoController extends ResourceController {
  DeleteTodoController(this._service);
  final ITodosService _service;

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
}
