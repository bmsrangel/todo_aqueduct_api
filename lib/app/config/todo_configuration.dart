import '../../todo_api.dart';
import 'database_connection_configuration.dart';

class TodoConfiguration extends Configuration {
  TodoConfiguration(String fileName) : super.fromFile(File(fileName));

  DatabaseConnectionConfiguration database;
}
