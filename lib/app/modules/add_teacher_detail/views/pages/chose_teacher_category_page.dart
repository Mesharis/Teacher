import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/search/search_doctor_category.dart';

import '../../../../styles/styles.dart';
import '../../controllers/add_doctor_detail_controller.dart';

class ChoseTeacherCategoryPage extends GetView<AddTeacherDetailController> {
  @override
  Widget build(BuildContext context) {
    controller.initDoctorCategory();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Teacher Category'.tr,
          style: Styles.appBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          controller.obx(
            (doctorCategory) => IconButton(
              onPressed: () async {
                controller.doctorCategory = await showSearch(
                  context: context,
                  delegate: SearchDoctorCategory(
                      doctorCategory: doctorCategory!,
                      doctorCategorySugestion: doctorCategory),
                );
                Get.back();
              },
              icon: Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: controller.obx(
        (doctorCategory) => Container(
          child: ListView.builder(
            itemCount: doctorCategory!.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(doctorCategory[index].categoryName!),
                onTap: () {
                  controller.doctorCategory = doctorCategory[index];
                  Get.back();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
