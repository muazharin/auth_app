import 'dart:convert';

import 'package:authenticator_app/app/data/models/users.dart';
import 'package:authenticator_app/app/data/services/api.dart';
import 'package:authenticator_app/app/data/utils/variables.dart';
import 'package:authenticator_app/app/data/widgets/snackbar_custom.dart';
import 'package:authenticator_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUsersController extends GetxController {
  var data = Get.arguments;
  var title = "Add";
  var titleBtn = "Tambah";
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
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
      var datas = data as UsersModel;
      name.text = datas.name!;
      email.text = datas.email!;
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
      var datas = data as UsersModel;
      try {
        final response = await Api().postWithToken(
          path: "${AppVariable.user}/${datas.id}",
          data: {
            "name": name.text,
            "email": email.text,
            "is_update_password": password.text.isNotEmpty,
            "password": password.text,
          },
        );
        var result = jsonDecode(response.toString());
        if (result['status'] == 200) {
          snackbarSuccess(message: "Berhasil mengedit");
          Get.until((route) => Get.currentRoute == Routes.USERS);
        } else {
          snackbarDanger(message: "Gagal mengedit");
        }
      } catch (e) {
        print("e");
        print(e);
        snackbarDanger(message: "Gagal mengedit");
      } finally {
        isLoading = false;
        update();
      }
    } else {
      try {
        final response = await Api().postWithToken(
          path: AppVariable.user,
          data: {
            "name": name.text,
            "email": email.text,
            "password": password.text,
          },
        );
        var result = jsonDecode(response.toString());
        if (result['status'] == 200) {
          snackbarSuccess(message: "Berhasil menambahkan");
          Get.until((route) => Get.currentRoute == Routes.USERS);
        } else {
          snackbarDanger(message: "Gagal menambahkan");
        }
      } catch (e) {
        print(e);
        snackbarDanger(message: "Gagal menambahkan");
      } finally {
        isLoading = false;
        update();
      }
    }
  }
}
