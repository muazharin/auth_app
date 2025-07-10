import 'package:authenticator_app/app/data/services/secure_storage.dart';
import 'package:authenticator_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  var box = SecureStorageService();
  @override
  // ignore: body_might_complete_normally_nullable
  RouteSettings? redirect(String? route) {
    var token = box.getData("token");
    token.then((v) {
      if (v == null || v.isEmpty) {
        return RouteSettings(name: Routes.LOGIN);
      } else {
        return null;
      }
    });
  }
}
