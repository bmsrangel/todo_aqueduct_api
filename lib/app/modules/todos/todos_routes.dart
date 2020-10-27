import 'package:get_it/get_it.dart';

import '../../../todo_api.dart';
import '../../routers/i_router_configure.dart';
import 'controller/get_add_todos_controller.dart';
import 'controller/update_delete_todo_controller.dart';

class TodosRoutes implements IRouterConfigure {
  @override
  void configure(Router router) {
    router.route("/todos").link(() => GetIt.I.get<GetAddTodosController>());
    router
        .route("/todos/:todoId")
        .link(() => GetIt.I.get<UpdateDeleteTodoController>());
  }
}
