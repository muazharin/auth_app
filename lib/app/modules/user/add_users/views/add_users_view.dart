import 'package:authenticator_app/app/data/themes/colors.dart';
import 'package:authenticator_app/app/data/utils/validators.dart';
import 'package:authenticator_app/app/data/widgets/button_default.dart';
import 'package:authenticator_app/app/data/widgets/input_password.dart';
import 'package:authenticator_app/app/data/widgets/input_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_users_controller.dart';

class AddUsersView extends GetView<AddUsersController> {
  const AddUsersView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text('${controller.title} User'),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GetBuilder<AddUsersController>(
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
                InputText(
                  hintText: "Masukkan Email",
                  controller: controller.email,
                  onChanged: (v) {},
                  validator: (v) => valEmail!(v, "Email"),
                ),
                const SizedBox(height: 16),
                InputPassword(
                  hintText: "Masukkan Password",
                  controller: controller.password,
                  onChanged: (v) {},
                  validator: controller.isEdit
                      ? null
                      : (v) => valString!(v, "Password"),
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
