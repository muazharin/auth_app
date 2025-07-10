import 'dart:convert';

import 'package:authenticator_app/app/data/models/my_keys.dart';
import 'package:authenticator_app/app/data/services/api.dart';
import 'package:authenticator_app/app/data/utils/variables.dart';
import 'package:authenticator_app/app/data/widgets/snackbar_custom.dart';
import 'package:authenticator_app/app/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddMyKeysController extends GetxController {
  var data = Get.arguments;
  var title = "Add";
  var titleBtn = "Tambah";
  var name = TextEditingController();
  var isLoading = false;
  var isActive = false;
  var isEdit = false;

  @override
  void onInit() {
    checkIsEdit();

    super.onInit();
  }

  void checkIsEdit() {
    isEdit = data != null;
    if (isEdit) {
      title = "Edit";
      titleBtn = "Edit";
      var datas = data as MyKeysModel;
      name.text = datas.name!;
      isActive = datas.active!;
      update();
    }
  }

  void handleSwitch(bool v) {
    isActive = v;
    update();
  }

  void handleAdd() async {
    isLoading = true;
    update();
    if (isEdit) {
      var datas = data as MyKeysModel;
      try {
        final response = await Api().putWithToken(
          path: "${AppVariable.client}/${datas.id}",
          data: {"name": name.text, "active": isActive},
        );
        var result = jsonDecode(response.toString());
        if (result['status'] == 200) {
          snackbarSuccess(message: "Berhasil mengedit");
          Get.until((route) => Get.currentRoute == Routes.MYKEYS);
        } else {
          snackbarDanger(message: "Gagal mengedit");
        }
      } catch (e) {
        snackbarDanger(message: "Gagal mengedit");
      } finally {
        isLoading = false;
        update();
      }
    } else {
      try {
        final response = await Api().postWithToken(
          path: AppVariable.client,
          data: {"name": name.text, "active": isActive},
        );
        var result = jsonDecode(response.toString());
        if (result['status'] == 200) {
          snackbarSuccess(message: "Berhasil menambahkan");
          Get.until((route) => Get.currentRoute == Routes.MYKEYS);
        } else {
          snackbarDanger(message: "Gagal menambahkan");
        }
      } catch (e) {
        snackbarDanger(message: "Gagal menambahkan");
      } finally {
        isLoading = false;
        update();
      }
    }
  }
}
