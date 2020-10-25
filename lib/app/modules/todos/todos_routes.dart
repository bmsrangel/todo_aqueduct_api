import 'package:get_it/get_it.dart';

import '../../../todo_api.dart';
import '../../routers/i_router_configure.dart';
import 'controller/delete_todo_controller.dart';
import 'controller/get_todos_controller.dart';
import 'controller/new_todo_controller.dart';
import 'controller/update_todo_controller.dart';

class TodosRoutes implements IRouterConfigure {
  @override
  void configure(Router router) {
    router.route("/todos/").link(() => GetIt.I.get<GetTodosController>());
    router.route("/todos/new").link(() => GetIt.I.get<NewTodoController>());
    router
        .route("/todos/update/:todoId")
        .link(() => GetIt.I.get<UpdateTodoController>());
    router
        .route("/todos/delete/:todoId")
        .link(() => GetIt.I.get<DeleteTodoController>());
  }
}
