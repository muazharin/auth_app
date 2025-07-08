import 'package:authenticator_app/app/data/services/secure_storage.dart';
import 'package:authenticator_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  final box = SecureStorageService();

  // @override
  // RouteSettings? redirect(String? route) {
  //   print("kepanggil gak sih?");
  //   return null;
  // }

  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    var token = await box.getData("token");
    print(token);
    if (token == null || token.isNotEmpty) {
      return GetNavConfig.fromRoute(Routes.LOGIN);
    }
    return super.redirectDelegate(route);
  }

  // @override
  // Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
  //   var token = await box.getData("token");
  //   print(token);

  //   if (token == null || token.isNotEmpty) {
  //     return GetNavConfig.fromRoute(Routes.LOGIN);
  //   }
  //   return await super.redirectDelegate(route);
  // }
}
