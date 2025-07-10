import 'package:authenticator_app/app/data/themes/colors.dart';
import 'package:authenticator_app/app/data/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';

import '../controllers/mykeys_controller.dart';

class MykeysView extends GetView<MykeysController> {
  const MykeysView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('My Keys', style: textSemiBold),
        centerTitle: true,
      ),
      body: GetBuilder<MykeysController>(
        builder: (context) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.isError) {
            return Center(child: Text(controller.error, style: textRegular));
          } else if (controller.data.isEmpty) {
            return Center(
              child: Text("Data tidak ditemukan", style: textRegular),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  const SizedBox(height: 16),
                  ...controller.data.map((v) {
                    // return Text(v.key!, style: textRegular);
                    return Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: AppColor.blue100),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Slidable(
                              endActionPane: ActionPane(
                                motion: ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (x) =>
                                        controller.handleEditBtn(v),
                                    backgroundColor: AppColor.yellow900,
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit,
                                  ),
                                  SlidableAction(
                                    onPressed: (v) {},
                                    backgroundColor: AppColor.red500,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete_outline_rounded,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Text(v.name!, style: textSemiBold),
                                    const SizedBox(width: 8),
                                    Icon(
                                      Icons.check_circle_rounded,
                                      size: 14,
                                      color: v.active!
                                          ? AppColor.green500
                                          : AppColor.grey500,
                                    ),
                                  ],
                                ),
                                subtitle: Text(v.key!, style: textRegular),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: GetBuilder<MykeysController>(
        builder: (context) {
          if (controller.data.isNotEmpty) {
            return FloatingActionButton(
              onPressed: () => controller.handleFloatingBtn(),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              child: Icon(Icons.add_rounded),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
