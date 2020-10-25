import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

import '../config/database_connection_configuration.dart';
import '../config/todo_configuration.dart';
import 'i_database_connection.dart';

@Injectable(as: IDatabaseConnection)
class DatabaseConnection implements IDatabaseConnection {
  DatabaseConnection(this._configuration);

  final TodoConfiguration _configuration;

  @override
  Future<MySqlConnection> openConnection() async {
    final DatabaseConnectionConfiguration database = _configuration.database;
    return MySqlConnection.connect(
      ConnectionSettings(
        host: database.host,
        port: database.port,
        user: database.user,
        password: database.password,
        db: database.databaseName,
      ),
    );
  }
}
