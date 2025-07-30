import 'dart:async';

import 'package:authenticator_app/app/data/models/application.dart';
import 'package:authenticator_app/app/data/services/secure_storage.dart';
import 'package:authenticator_app/app/data/widgets/snackbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp/otp.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QrScannerController extends GetxController {
  QRViewController? qrController;
  final qrKey = GlobalKey();
  var box = SecureStorageService();
  var code = ''.obs;
  var count = 0;
  var listApp = <Application>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onQRViewCreated(QRViewController controller) {
    qrController = controller;
    controller.scannedDataStream.listen((scanData) async {
      // code.value = scanData.code!;
      // update();
      // await Get.rootDelegate.popRoute(result: "testing");
      count++;
      if (count == 1) {
        addApp(scanData.code!);
      }
    });
  }

  Future<void> addApp(String code) async {
    Uri uri = Uri.parse(code);

    var secretKey = uri.queryParameters['secret'] ?? '';
    var issuer = uri.queryParameters['issuer'] ?? '';
    var algorithm = uri.queryParameters['algorithm'] ?? '';
    var name = uri.pathSegments[0];
    if (secretKey == '' || issuer == '' || name == '') {
      Get.rootDelegate.popRoute();
      snackbarDanger(message: "QR Code invalid");
      return;
    }

    final newUser = Application(
      id: DateTime.now().millisecondsSinceEpoch,
      name: name,
      issuer: issuer,
      secretKey: secretKey,
      kodeOtp: "",
      algorithm: algorithm,
    );
    listApp.add(newUser);
    final jsonString = encodeAppllicationList(listApp);
    await box.saveData('application_list', jsonString);
    Timer(const Duration(milliseconds: 100), () => getAllApp());
  }

  Future<void> getAllApp() async {
    print("getAllApp()");
    final jsonString = await box.getData('application_list') ?? '[]';
    final apps = decodeApplicationList(jsonString);
    print("apps.length");
    print(apps.length);
    for (var i = 0; i < apps.length; i++) {
      apps[i].kodeOtp = _generateKodeOtp(apps[i].secretKey, apps[i].algorithm);
    }
    listApp.value = apps;
    update();
    Get.rootDelegate.popRoute();
  }

  String _generateKodeOtp(String secretKey, algorithm) {
    String totp = OTP.generateTOTPCodeString(
      secretKey,
      DateTime.now().millisecondsSinceEpoch,
      interval: 30,
      length: 6,
      algorithm: algorithm == "SHA512" ? Algorithm.SHA512 : Algorithm.SHA1,
      isGoogle: true,
    );
    return totp;
  }

  Future<void> removeAllApps() async {
    listApp.value = [];
    box.deleteData('application_list');
    update();
  }

  Future<void> doDelete(int i) async {
    listApp.removeAt(i);
    final jsonString = encodeAppllicationList(listApp);
    box.saveData('application_list', jsonString);
    Get.rootDelegate.popRoute();
  }

  @override
  void onClose() {
    qrController?.dispose();
    super.onClose();
  }

  void handleBack() {
    Get.rootDelegate.popRoute(result: "testing");
  }
}
