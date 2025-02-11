import 'package:rachadinha/data/models/user_model.dart';
import 'package:rachadinha/data/services/client_http.dart';
import 'package:rachadinha/domain/dtos/credentials.dart';
import 'package:result_dart/result_dart.dart';

class AuthClientHttp {
  final ClientHttp _clientHttp;

  AuthClientHttp(this._clientHttp);

  AsyncResult<LoggedUser> login(Credentials credentials) async {
    // final response = await _clientHttp.post('/login', {
    //   'email': credentials.email,
    //   'password': credentials.password,
    // });

    // return response.map((response) {
    //   return LoggedUser.fromJson(response.data);
    // });

    await Future.delayed(const Duration(seconds: 2));
    return const Success(LoggedUser(
      id: 1,
      name: 'leandro mesquita',
      email: 'leandro.mesquita@bridsolucoes.com.br',
      token: 'token',
      refreshToken: 'refreshToken',
    ));
  }
}
