import 'package:get/get.dart';

import '../controllers/add_my_keys_controller.dart';

class AddMyKeysBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddMyKeysController>(
      () => AddMyKeysController(),
    );
  }
}
