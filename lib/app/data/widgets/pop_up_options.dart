import 'package:authenticator_app/app/data/themes/colors.dart';
import 'package:authenticator_app/app/data/themes/typography.dart';
import 'package:authenticator_app/app/data/widgets/button_default.dart';
import 'package:authenticator_app/app/data/widgets/button_outlined.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopUpDelete extends StatelessWidget {
  const PopUpDelete({
    super.key,
    this.title,
    this.detail,
    this.onTap,
    this.isShowButton = true,
    this.isShowIcon = false,
  });
  final String? title;
  final String? detail;
  final bool? isShowButton;
  final bool? isShowIcon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: InkWell(
        onTap: () => Get.back(),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            margin: const EdgeInsets.symmetric(horizontal: 56),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                isShowIcon! ? Icon(Icons.delete) : const SizedBox(),
                Text(
                  "$title",
                  style: textSemiBold.copyWith(
                    fontSize: 16,
                    color: AppColor.red700,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "$detail",
                  textAlign: TextAlign.center,
                  style: textRegular.copyWith(color: AppColor.grey700),
                ),
                const SizedBox(height: 24),
                isShowButton!
                    ? Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ButtonOutlined(
                              text: "Cancel",
                              textSize: 12,
                              radius: 8,
                              onTap: () => Get.back(),
                              borderColor: AppColor.grey500,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 1,
                            child: ButtonDefault(
                              text: "Yes",
                              textSize: 12,
                              radius: 8,
                              color: AppColor.red700,
                              onTap: onTap,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
