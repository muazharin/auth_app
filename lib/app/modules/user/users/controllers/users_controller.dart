import 'dart:async';
import 'dart:convert';

import 'package:authenticator_app/app/data/models/users.dart';
import 'package:authenticator_app/app/data/services/api.dart';
import 'package:authenticator_app/app/data/services/secure_storage.dart';
import 'package:authenticator_app/app/data/utils/others.dart';
import 'package:authenticator_app/app/data/utils/variables.dart';
import 'package:authenticator_app/app/data/widgets/pop_up_options.dart';
import 'package:authenticator_app/app/data/widgets/snackbar_custom.dart';
import 'package:authenticator_app/app/routes/app_pages.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class UsersController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var isLoading = true;
  var isError = false;
  var error = '';
  var page = 1;
  var data = <UsersModel>[];
  var box = SecureStorageService();
  late final slideController = SlidableController(this);

  @override
  void onInit() {
    getAllData();
    super.onInit();
  }

  void handleBack() {
    Get.rootDelegate.popRoute();
  }

  void getAllData() async {
    isLoading = true;
    isError = false;
    error = "";
    data = [];
    page = 1;
    try {
      final response = await Api().getWithToken(path: AppVariable.user);
      var result = jsonDecode(response.toString());
      if (result['status'] == 200) {
        data = (result['data']['rows'] as List)
            .map<UsersModel>((v) => UsersModel.fromJson(v))
            .toList();
        doShowOption();
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

  void doShowOption() async {
    var isShowOption = await box.getData('show_option_keys');
    if (isShowOption == null || isShowOption.isEmpty) {
      // await box.saveData('show_option_keys', 'done');
      Timer(const Duration(milliseconds: 100), () {
        slideController.openEndActionPane();
      });
      Timer(const Duration(milliseconds: 1200), () {
        slideController.close();
      });
    }
  }

  void handleFloatingBtn() {
    Get.toNamed(Routes.ADD_USERS)!.then((_) => getAllData());
  }

  void handleEditBtn(UsersModel v) {
    Get.toNamed(Routes.ADD_USERS, arguments: v)!.then((_) => getAllData());
  }

  void handleDeleteBtn(int? id) {
    Get.dialog(
      PopUpDelete(
        title: "Hapus User",
        detail: "Anda yakin menghapus data ini?",
        onTap: () => doDelete(id),
      ),
    );
  }

  void doDelete(int? id) async {
    Get.back();
    loading(text: "Menunggu...");
    try {
      final response = await Api().deleteWithToken(
        path: "${AppVariable.user}/$id",
      );
      var result = jsonDecode(response.toString());
      if (result['status'] == 200) {
        Get.back();
        snackbarSuccess(message: "Berhasil menghapus");
      } else {
        Get.back();
        snackbarDanger(message: result['message']);
      }
    } catch (e) {
      Get.back();
      snackbarDanger(message: e.toString());
    } finally {
      getAllData();
    }
  }
}
