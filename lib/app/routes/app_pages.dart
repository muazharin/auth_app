import 'package:get/get.dart';

import '../data/services/middleware.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/keys/add_my_keys/bindings/add_my_keys_binding.dart';
import '../modules/keys/add_my_keys/views/add_my_keys_view.dart';
import '../modules/keys/mykeys/bindings/mykeys_binding.dart';
import '../modules/keys/mykeys/views/mykeys_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/qr_scanner/bindings/qr_scanner_binding.dart';
import '../modules/qr_scanner/views/qr_scanner_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/user/add_users/bindings/add_users_binding.dart';
import '../modules/user/add_users/views/add_users_view.dart';
import '../modules/user/users/bindings/users_binding.dart';
import '../modules/user/users/views/users_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

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
    GetPage(
      name: _Paths.USERS,
      page: () => const UsersView(),
      binding: UsersBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.ADD_USERS,
      page: () => const AddUsersView(),
      binding: AddUsersBinding(),
    ),
    GetPage(
      name: _Paths.QR_SCANNER,
      page: () => const QrScannerView(),
      binding: QrScannerBinding(),
    ),
  ];
}
