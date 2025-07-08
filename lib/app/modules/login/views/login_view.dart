import 'package:authenticator_app/app/data/themes/colors.dart';
import 'package:authenticator_app/app/data/themes/typography.dart';
import 'package:authenticator_app/app/data/utils/validators.dart';
import 'package:authenticator_app/app/data/widgets/button_default.dart';
import 'package:authenticator_app/app/data/widgets/input_password.dart';
import 'package:authenticator_app/app/data/widgets/input_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text('Login', style: textSemiBold),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: controller.key,
          child: ListView(
            children: [
              Image.asset("assets/png/auth.png", height: Get.width / 2),
              SizedBox(height: 16),
              Text(
                "Silakan login untuk mengakses layanan secara pribadi dan aman.",
                textAlign: TextAlign.center,
                style: textSemiBold,
              ),
              SizedBox(height: 32),
              InputText(
                hintText: "Masukkan Email",
                onChanged: (v) {},
                controller: controller.email,
                validator: (v) => valEmail!(v, "Email"),
              ),
              SizedBox(height: 8),
              InputPassword(
                hintText: "Masukkan Password",
                onChanged: (v) {},
                controller: controller.password,
                validator: (v) => valString!(v, "Password"),
                // validator: (v) => valPassword!(v, "Password"),
              ),
              SizedBox(height: 16),
              ButtonDefault(
                text: "Masuk",
                color: AppColor.blue200,
                onTap: () => controller.handleLogin(),
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
