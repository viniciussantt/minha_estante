import 'package:get_it/get_it.dart';
import 'package:minha_estante/features/sign_in/sign_in_controller.dart';
import 'package:minha_estante/features/sign_up/sign_up_controller.dart';
import 'package:minha_estante/features/splash/splash_controller.dart';
import 'package:minha_estante/services/auth_service.dart';
import 'package:minha_estante/services/firebase_auth_service.dart';
import 'package:minha_estante/services/secure_storage.dart';

// Utilizando o get_it para fazer a injeção de dependência

final locator = GetIt.instance;

void setupDependencies() {
  // Utilizando o padrão singleton para fazer a instância
  // Utilização do registerLazySingleton cria o objeto apenas quando for utilizando e não quando a aplicação for iniciada
  locator.registerLazySingleton<AuthService>(() => FirebaseAuthService());

  // Utilizando o padrão factory para criação de objetos
  locator.registerFactory<SplashController>(
      () => SplashController(const SecureStorage()));

  locator.registerFactory<SignInController>(
      () => SignInController(locator.get<AuthService>()));

  locator.registerFactory<SignUpController>(
      () => SignUpController(locator.get<AuthService>()));
}
