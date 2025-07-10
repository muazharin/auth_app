import 'package:authenticator_app/app/data/services/secure_storage.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  var isLoggedIn = false.obs;
  final box = SecureStorageService();

  @override
  void onInit() {
    login();
    super.onInit();
  }

  void login() async {
    final token = await box.getData("token");
    if (token == null || token.isEmpty) {
      isLoggedIn.value = true;
    } else {
      isLoggedIn.value = true;
    }
  }
}
