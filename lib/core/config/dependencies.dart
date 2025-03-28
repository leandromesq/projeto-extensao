import 'package:auto_injector/auto_injector.dart';
import 'package:dio/dio.dart';
import 'package:rachadinha/data/repositories/auth/auth_repository.dart';
import 'package:rachadinha/data/repositories/auth/auth_repository_impl.dart';
import 'package:rachadinha/data/repositories/rachadinha/rachadinha_repository.dart';
import 'package:rachadinha/data/repositories/rachadinha/rachadinha_repository_impl.dart';
import 'package:rachadinha/data/services/auth/auth_firestore.dart';
import 'package:rachadinha/data/services/auth/auth_local_storage.dart';
import 'package:rachadinha/data/services/local_storage.dart';
import 'package:rachadinha/data/services/rachadinha/rachadinha_firestore.dart';
import 'package:rachadinha/ui/auth/viewmodels/auth_viewmodel.dart';
import 'package:rachadinha/ui/home/viewmodels/home_viewmodel.dart';

final injector = AutoInjector();

void setupInjection() {
  //data
  injector.addInstance<Dio>(Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
    ),
  ));
  injector.addSingleton(LocalStorage.new);
  injector.addSingleton(AuthLocalStorage.new);
  injector.addSingleton(AuthFirestore.new);
  injector.addSingleton<AuthRepository>(AuthRepositoryImpl.new);
  injector.addSingleton(RachadinhaFirestore.new);
  injector.addSingleton<RachadinhaRepository>(RachadinhaRepositoryImpl.new);

  //domain

  //ui
  injector.addSingleton(AuthViewModel.new);
  injector.addSingleton(HomeViewModel.new);

  injector.commit();
}
