import 'package:get_it/get_it.dart';

import '../../../todo_api.dart';
import '../../routers/i_router_configure.dart';
import 'controller/todos_controller.dart';

class TodosRoutes implements IRouterConfigure {
  @override
  void configure(Router router) {
    router.route("/todos/[:todoId]").link(() => GetIt.I.get<TodosController>());
  }
}
