import 'package:authenticator_app/app/data/themes/colors.dart';
import 'package:authenticator_app/app/data/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void loading({String? text}) {
  Get.generalDialog(
    pageBuilder: (context, i, j) => WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          width: Get.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                text!,
                textAlign: TextAlign.center,
                style: textRegular.copyWith(
                  fontSize: 16,
                  color: AppColor.grey500,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
