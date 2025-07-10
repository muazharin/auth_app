import 'dart:convert';

import 'package:authenticator_app/app/data/models/my_keys.dart';
import 'package:authenticator_app/app/data/services/api.dart';
import 'package:authenticator_app/app/data/utils/variables.dart';
import 'package:authenticator_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class MykeysController extends GetxController {
  var isLoading = true;
  var isError = false;
  var error = '';
  var page = 1;
  var data = <MyKeysModel>[];

  @override
  void onInit() {
    getAllData();
    super.onInit();
  }

  void getAllData() async {
    isLoading = true;
    isError = false;
    error = "";
    data = [];
    page = 1;
    try {
      final response = await Api().getWithToken(path: AppVariable.mykeys);
      var result = jsonDecode(response.toString());
      if (result['status'] == 200) {
        print(result);
        data = (result['data']['rows'] as List)
            .map<MyKeysModel>((v) => MyKeysModel.fromJson(v))
            .toList();
      } else {
        data = [];
      }
      isLoading = false;
      update();
    } catch (e) {
      isError = true;
      error = e.toString();
      isLoading = false;
      update();
    }
  }

  void handleFloatingBtn() {
    Get.toNamed(Routes.ADD_MY_KEYS)!.then((_) => getAllData());
  }

  void handleEditBtn(MyKeysModel v) {
    Get.toNamed(Routes.ADD_MY_KEYS, arguments: v)!.then((_) => getAllData());
  }
}
