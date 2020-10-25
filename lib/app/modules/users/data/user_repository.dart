import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';
import 'package:uuid/uuid.dart';

import '../../../database/i_database_connection.dart';
import '../../../entities/user.dart';
import '../../../exceptions/database_error_exception.dart';
import '../../../exceptions/duplicated_key_exception.dart';
import '../../../exceptions/user_not_found_exception.dart';
import '../../../helpers/crypt_helpers.dart';
import '../view_models/register_user_input_model.dart';
import 'i_user_repository.dart';

@LazySingleton(as: IUserRepository)
class UserRepository implements IUserRepository {
  UserRepository(this._connection);
  final IDatabaseConnection _connection;

  @override
  Future<User> login(String email, String password) async {
    final MySqlConnection conn = await _connection.openConnection();
    try {
      final Results results = await conn
          .query("SELECT * FROM users WHERE email = ? AND password = ?", [
        email,
        CryptHelpers.generateSHA256Hash(password),
      ]);
      if (results.isEmpty) {
        throw UserNotFoundException();
      }
      final fields = results.first.fields;
      return User(
        id: fields["id"] as String,
        name: fields["name"] as String,
        email: fields["email"] as String,
      );
    } on MySqlException catch (_) {
      throw DatabaseErrorException("Erro ao requisitar dados de usuário");
    } finally {
      await conn?.close();
    }
  }

  @override
  Future<void> saveUser(RegisterUserInputModel registerUserInputModel) async {
    final MySqlConnection conn = await _connection.openConnection();
    final Uuid uuid = Uuid();
    try {
      await conn.query(
          "INSERT users(id, name, email, password) VALUES (?, ?, ?, ?)", [
        uuid.v4(),
        registerUserInputModel.name,
        registerUserInputModel.email,
        CryptHelpers.generateSHA256Hash(registerUserInputModel.password),
      ]);
    } on MySqlConnection catch (e) {
      print(e);
      throw DatabaseErrorException("Erro ao registrar usuário");
    } on MySqlException catch (e) {
      if (e.errorNumber == 1062) {
        print(e.toString());
        throw DuplicatedKeyException("E-mail já cadastrado.");
      }
    } finally {
      await conn?.close();
    }
  }
}
