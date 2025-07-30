import 'package:authenticator_app/app/data/themes/colors.dart';
import 'package:authenticator_app/app/data/themes/typography.dart';
import 'package:authenticator_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      controller: controller.drawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff38bdf8), Color(0xff38bdf8).withOpacity(.3)],
          ),
        ),
      ),
      disabledGestures: true,
      childDecoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 0.0),
        ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "Authenticator App",
                      style: textSemiBold.copyWith(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Text(
                        "MA",
                        style: textSemiBold.copyWith(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),

              ListTile(
                onTap: () => controller.handleToNamed(Routes.MYKEYS),
                leading: Icon(Icons.key),
                title: Text(
                  'My Keys',
                  style: textRegular.copyWith(color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () => controller.handleToNamed(Routes.USERS),
                leading: Icon(Icons.people_outline_rounded),
                title: Text(
                  'Users',
                  style: textRegular.copyWith(color: Colors.white),
                ),
              ),
              Divider(color: Colors.white),
              ListTile(
                onTap: () => controller.handleToNamed(Routes.USERS),
                leading: Icon(Icons.logout_rounded),
                title: Text(
                  'Logout',
                  style: textRegular.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Authenticator App",
            style: textSemiBold.copyWith(fontSize: 20),
          ),
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () => controller.handleDrawer(),
            child: Icon(Icons.menu_rounded),
          ),
        ),
        body: Obx(() {
          int base = controller.currentSecond.value;
          double progress = (base < 30) ? base / 30 : (base - 30) / 29;
          if (controller.qrController.listApp.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/svg/auth1.svg",
                    width: Get.width / 2,
                  ),

                  Text(
                    "Selamat datang!",
                    style: textSemiBold.copyWith(fontSize: 20),
                  ),
                  Text(
                    "Silahkan tambahkan akun Anda sekarang",
                    style: textSemiBold,
                  ),
                  SizedBox(height: 32),
                  GestureDetector(
                    onTap: () => controller.handleAdd(),
                    child: Icon(Icons.add_circle_rounded, size: 56),
                  ),
                ],
              ),
            );
          } else {
            return ListView(
              children: [
                ...controller.qrController.listApp.asMap().entries.map((v) {
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          key: ValueKey(v.key),
                          onPressed: (_) => controller.handleDeleteBtn(v.key),
                          backgroundColor: AppColor.red500,
                          foregroundColor: Colors.white,
                          icon: Icons.delete_outline_rounded,
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(v.value.name, style: textRegular),
                      subtitle: Text(
                        v.value.kodeOtp,
                        style: textSemiBold.copyWith(fontSize: 36),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.copy_rounded),
                          const SizedBox(width: 8),
                          TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 0, end: progress),
                            duration: Duration(milliseconds: 1000),
                            builder: (context, value, _) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      value: value,
                                      strokeWidth: 5,
                                      backgroundColor: Colors.blue,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            );
          }
        }),
      ),
    );
  }
}
