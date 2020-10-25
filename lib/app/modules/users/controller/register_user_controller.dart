import 'package:injectable/injectable.dart';

import '../../../../todo_api.dart';
import '../../../exceptions/duplicated_key_exception.dart';
import '../service/i_user_service.dart';
import '../view_models/register_user_input_model.dart';
import 'models/register_rq.dart';

@Injectable()
class RegisterUserController extends ResourceController {
  RegisterUserController(this._service);
  final IUserService _service;

  @Operation.post()
  Future<Response> registerUser(@Bind.body() RegisterRq registerRq) async {
    try {
      final RegisterUserInputModel userInputModel = mapper(registerRq);
      await _service.registerUser(userInputModel);
      return Response.created("",
          body: {"message": "Usuário criado com sucesso"});
    } on DuplicatedKeyException catch (e) {
      return Response.conflict(body: {
        "message": "Erro ao registrar novo usuário: ${e.message}",
      });
    } catch (e) {
      print(e);
      return Response.serverError(body: {
        "message": "Erro ao registrar novo usuário",
      });
    }
  }

  RegisterUserInputModel mapper(RegisterRq registerRq) {
    return RegisterUserInputModel(
      name: registerRq.name,
      email: registerRq.email,
      password: registerRq.password,
    );
  }
}
