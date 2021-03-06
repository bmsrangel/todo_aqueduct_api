import '../../todo_api.dart';
import '../modules/todos/todos_routes.dart';
import '../modules/users/users_routes.dart';
import 'i_router_configure.dart';

class RouterConfigure {
  RouterConfigure(this._router);
  final Router _router;
  final List<IRouterConfigure> routers = [
    UsersRoutes(),
    TodosRoutes(),
  ];

  void configure() => routers.forEach((route) => route.configure(_router));
}
