import 'dart:async';

import 'package:authenticator_app/app/data/widgets/pop_up_options.dart';
import 'package:authenticator_app/app/data/widgets/snackbar_custom.dart';
import 'package:authenticator_app/app/modules/qr_scanner/controllers/qr_scanner_controller.dart';
import 'package:authenticator_app/app/routes/app_pages.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var qrController = Get.find<QrScannerController>();
  var currentSecond = 0.obs;
  var progress = 0.obs;
  var drawerController = AdvancedDrawerController();

  void startAutoRefresh() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      currentSecond.value = now.second;
      if (now.second == 0 || now.second == 30) {
        qrController.getAllApp();
      }
    });
  }

  void handleAdd() {
    Get.rootDelegate.toNamed(Routes.QR_SCANNER).then((v) {
      snackbarSuccess(message: "testing");
    });
  }

  void handleDeleteBtn(int? id) {
    Get.dialog(
      PopUpDelete(
        title: "Hapus",
        detail: "Anda yakin menghapus data ini?",
        onTap: () => qrController.doDelete(id!),
      ),
    );
  }

  @override
  void onInit() {
    qrController.getAllApp();
    startAutoRefresh();
    super.onInit();
  }

  void handleDrawer() {
    drawerController.showDrawer();
  }

  void handleToNamed(String route) {
    Get.rootDelegate.toNamed(route);
  }
}
