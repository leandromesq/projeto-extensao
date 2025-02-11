import 'package:auto_injector/auto_injector.dart';
import 'package:dio/dio.dart';
import 'package:rachadinha/data/repositories/auth/auth_repository.dart';
import 'package:rachadinha/data/repositories/auth/auth_repository_impl.dart';
import 'package:rachadinha/data/services/auth/auth_client_http.dart';
import 'package:rachadinha/data/services/auth/auth_local_storage.dart';
import 'package:rachadinha/data/services/client_http.dart';
import 'package:rachadinha/data/services/local_storage.dart';
import 'package:rachadinha/ui/auth/viewmodels/auth_viewmodel.dart';

final injector = AutoInjector();

void setupInjection() {
  //data
  injector.addInstance<Dio>(Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
    ),
  ));
  injector.addSingleton(LocalStorage.new);
  injector.addSingleton(ClientHttp.new);
  injector.addSingleton(AuthLocalStorage.new);
  injector.addSingleton(AuthClientHttp.new);
  injector.addSingleton<AuthRepository>(AuthRepositoryImpl.new);

  //domain

  //ui
  injector.addSingleton(AuthViewmodel.new);

  injector.commit();
}
