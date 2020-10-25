import 'package:injectable/injectable.dart';

import '../../../../todo_api.dart';
import '../../../entities/todo.dart';
import '../service/i_todos_service.dart';

@Injectable()
class GetTodosController extends ResourceController {
  GetTodosController(this._service);
  final ITodosService _service;

  @Operation.get()
  Future<Response> getTodosByUser(
      @Bind.header("x-user-id") String userId) async {
    try {
      final List<Todo> todoList = await _service.getTodosByUserId(userId);
      return Response.ok(todoList.map((todo) => todo.toJson()).toList());
    } catch (e) {
      return Response.serverError(body: {
        "message": "Erro ao carregar todos",
      });
    }
  }
}
