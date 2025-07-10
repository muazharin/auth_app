import 'package:get/get.dart';

import '../controllers/mykeys_controller.dart';

class MykeysBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MykeysController>(
      () => MykeysController(),
    );
  }
}
