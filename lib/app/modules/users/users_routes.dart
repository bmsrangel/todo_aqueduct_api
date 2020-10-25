import 'package:get_it/get_it.dart';

import '../../../todo_api.dart';
import '../../routers/i_router_configure.dart';
import 'controller/login_user_controller.dart';
import 'controller/register_user_controller.dart';

class UsersRoutes implements IRouterConfigure {
  @override
  void configure(Router router) {
    router.route("/user").link(() => GetIt.I.get<RegisterUserController>());
    router.route("/user/auth").link(() => GetIt.I.get<LoginUserController>());
  }
}
