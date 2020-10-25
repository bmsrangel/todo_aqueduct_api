import 'package:get_it/get_it.dart';

import 'app/config/service_locator_config.dart';
import 'app/config/todo_configuration.dart';
import 'app/routers/router_configure.dart';
import 'todo_api.dart';

class TodoApiChannel extends ApplicationChannel {
  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    GetIt.instance.registerLazySingleton(
        () => TodoConfiguration(options.configurationFilePath));
    configureDependencies();
  }

  @override
  Controller get entryPoint {
    final router = Router();

    RouterConfigure(router).configure();

    return router;
  }
}
