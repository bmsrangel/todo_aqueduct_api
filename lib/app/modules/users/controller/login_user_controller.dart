import 'package:injectable/injectable.dart';

import '../../../../todo_api.dart';
import '../../../entities/user.dart';
import '../../../exceptions/user_not_found_exception.dart';
import '../service/i_user_service.dart';
import 'models/login_rq.dart';

@Injectable()
class LoginUserController extends ResourceController {
  LoginUserController(this._service);

  final IUserService _service;

  @Operation.post()
  Future<Response> login(@Bind.body() LoginRq loginRq) async {
    try {
      final User user = await _service.login(loginRq.email, loginRq.password);
      return Response.ok(user.toJson());
    } on UserNotFoundException catch (e) {
      print(e);
      return Response.notFound(body: {
        "message": "Usuário não encontrado",
      });
    } catch (e) {
      print(e);
      return Response.serverError(body: {"message": "Server error"});
    }
  }
}
