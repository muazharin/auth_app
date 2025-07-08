import 'package:authenticator_app/app/data/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/svg/auth1.svg", width: Get.width / 2),
            SizedBox(height: 32),
            Text("Selamat datang!", style: textSemiBold.copyWith(fontSize: 20)),
            Text("Silahkan tambahkan akun Anda sekarang", style: textSemiBold),
            SizedBox(height: 16),
            Icon(Icons.add_circle_rounded, size: 56),
          ],
        ),
      ),
    );
  }
}
