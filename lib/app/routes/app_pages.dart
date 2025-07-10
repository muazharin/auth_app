import 'package:get/get.dart';

import '../data/services/middleware.dart';
import '../modules/keys/add_my_keys/bindings/add_my_keys_binding.dart';
import '../modules/keys/add_my_keys/views/add_my_keys_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/keys/mykeys/bindings/mykeys_binding.dart';
import '../modules/keys/mykeys/views/mykeys_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MYKEYS;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.MYKEYS,
      page: () => const MykeysView(),
      binding: MykeysBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.ADD_MY_KEYS,
      page: () => const AddMyKeysView(),
      binding: AddMyKeysBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
