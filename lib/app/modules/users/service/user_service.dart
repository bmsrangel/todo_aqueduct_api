import 'package:injectable/injectable.dart';

import '../../../entities/user.dart';
import '../data/i_user_repository.dart';
import '../view_models/register_user_input_model.dart';
import 'i_user_service.dart';

@LazySingleton(as: IUserService)
class UserService implements IUserService {
  UserService(this._repository);
  final IUserRepository _repository;

  @override
  Future<User> login(String email, String password) async {
    return await _repository.login(email, password);
  }

  @override
  Future<void> registerUser(
      RegisterUserInputModel registerUserInputModel) async {
    return await _repository.saveUser(registerUserInputModel);
  }
}
