import 'package:authenticator_app/app/modules/qr_scanner/controllers/qr_scanner_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<QrScannerController>(() => QrScannerController());
  }
}
