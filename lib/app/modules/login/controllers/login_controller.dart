import 'dart:convert';

import 'package:authenticator_app/app/data/services/api.dart';
import 'package:authenticator_app/app/data/services/secure_storage.dart';
import 'package:authenticator_app/app/data/utils/variables.dart';
import 'package:authenticator_app/app/data/widgets/snackbar_custom.dart';
import 'package:authenticator_app/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var box = SecureStorageService();
  var key = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  var isLoading = false;

  void handleLogin() async {
    if (key.currentState!.validate()) {
      isLoading = true;
      update();
      try {
        final response = await Api().postWithoutToken(
          path: AppVariable.login,
          data: {"email": email.text, "password": password.text},
        );
        var result = jsonDecode(response.toString());

        if (result['status'] == 200) {
          await box.saveData("token", result["data"]["token"]);
          Get.rootDelegate.offNamed(Routes.HOME);
        } else {
          snackbarDanger(message: result['message']);
        }
      } catch (e) {
        snackbarDanger(message: "Terjadi kesalahan");
      } finally {
        isLoading = false;
        update();
      }
    }
  }
}
