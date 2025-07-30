import 'package:authenticator_app/app/data/themes/colors.dart';
import 'package:authenticator_app/app/data/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';

import '../controllers/users_controller.dart';

class UsersView extends GetView<UsersController> {
  const UsersView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Users', style: textSemiBold),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () => controller.handleBack(),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: GetBuilder<UsersController>(
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
                  ...controller.data.asMap().entries.map((v) {
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
                              controller: v.key == 0
                                  ? controller.slideController
                                  : null,
                              endActionPane: ActionPane(
                                motion: ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    key: ValueKey(v.key),
                                    onPressed: (x) =>
                                        controller.handleEditBtn(v.value),
                                    backgroundColor: AppColor.yellow900,
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit,
                                  ),
                                  SlidableAction(
                                    onPressed: (x) =>
                                        controller.handleDeleteBtn(v.value.id),
                                    backgroundColor: AppColor.red500,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete_outline_rounded,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Text(v.value.name!, style: textSemiBold),
                                subtitle: Text(
                                  v.value.email!,
                                  style: textRegular,
                                ),
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
      floatingActionButton: GetBuilder<UsersController>(
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
