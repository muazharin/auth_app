import 'package:authenticator_app/app/data/themes/colors.dart';
import 'package:authenticator_app/app/data/themes/typography.dart';
import 'package:authenticator_app/app/data/utils/validators.dart';
import 'package:authenticator_app/app/data/widgets/button_default.dart';
import 'package:authenticator_app/app/data/widgets/input_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_my_keys_controller.dart';

class AddMyKeysView extends GetView<AddMyKeysController> {
  const AddMyKeysView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text('${controller.title} My Key'),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GetBuilder<AddMyKeysController>(
          builder: (context) {
            return ListView(
              children: [
                InputText(
                  hintText: "Masukkan Nama",
                  controller: controller.name,
                  onChanged: (v) {},
                  validator: (v) => valString!(v, "Nama"),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Aktifkan",
                      style: textSemiBold.copyWith(fontSize: 16),
                    ),
                    Switch(
                      value: controller.isActive,
                      onChanged: (v) => controller.handleSwitch(v),
                      activeColor: AppColor.blue500,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ButtonDefault(
                  text: controller.titleBtn,
                  color: AppColor.blue500,
                  onTap: () => controller.handleAdd(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
