// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../database/database_connection.dart';
import '../modules/todos/controller/get_add_todos_controller.dart';
import '../database/i_database_connection.dart';
import '../modules/todos/data/i_todos_repository.dart';
import '../modules/todos/service/i_todos_service.dart';
import '../modules/users/data/i_user_repository.dart';
import '../modules/users/service/i_user_service.dart';
import '../modules/users/controller/login_user_controller.dart';
import '../modules/users/controller/register_user_controller.dart';
import 'todo_configuration.dart';
import '../modules/todos/data/todos_repository.dart';
import '../modules/todos/service/todos_service.dart';
import '../modules/todos/controller/update_delete_todo_controller.dart';
import '../modules/users/data/user_repository.dart';
import '../modules/users/service/user_service.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factory<IDatabaseConnection>(
      () => DatabaseConnection(get<TodoConfiguration>()));
  gh.lazySingleton<ITodosRepository>(
      () => TodosRepository(get<IDatabaseConnection>()));
  gh.lazySingleton<ITodosService>(() => TodosService(get<ITodosRepository>()));
  gh.lazySingleton<IUserRepository>(
      () => UserRepository(get<IDatabaseConnection>()));
  gh.lazySingleton<IUserService>(() => UserService(get<IUserRepository>()));
  gh.factory<LoginUserController>(
      () => LoginUserController(get<IUserService>()));
  gh.factory<RegisterUserController>(
      () => RegisterUserController(get<IUserService>()));
  gh.factory<UpdateDeleteTodoController>(
      () => UpdateDeleteTodoController(get<ITodosService>()));
  gh.factory<GetAddTodosController>(
      () => GetAddTodosController(get<ITodosService>()));
  return get;
}
