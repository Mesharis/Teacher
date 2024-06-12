import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/chose_teacher_category_page.dart';
import 'widgets/display_image.dart';
import '../../login/views/widgets/submit_button.dart';

import '../../../styles/styles.dart';
import '../controllers/add_doctor_detail_controller.dart';

class AddDoctorDetailView extends GetView<AddTeacherDetailController> {
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Teacher Information'.tr,
          style: Styles.appBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: controller.formkey,
          child: GetX<AddTeacherDetailController>(
            builder: (controller) => Column(
              children: [
                DisplayImage(
                    imagePath: controller.profilePicUrl.value,
                    onPressed: () {
                      controller.toEditProfilePic();
                    }),
                SizedBox(height: 20),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    node.nextFocus();
                  },
                  validator: ((value) {
                    if (value!.length < 3) {
                      return 'Name must be more than two characters'.tr;
                    } else {
                      return null;
                    }
                  }),
                  initialValue: controller.doctor == null
                      ? ''
                      : controller.doctorName.value,
                  onSaved: (name) {
                    controller.doctorName.value = name!;
                  },
                  decoration: InputDecoration(
                    hintText: controller.doctor == null
                        ? 'Teacher Name e.g : Mr. Maria Alexandra'.tr
                        : '',
                    labelStyle: TextStyle(fontSize: 15, color: Colors.black87),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Styles.secondaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Styles.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                  ),
                  cursorColor: Styles.primaryColor,
                ),
                SizedBox(height: 20),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    node.nextFocus();
                  },
                  initialValue: controller.doctor == null
                      ? null
                      : controller.doctorHospital.value,
                  onSaved: (hospital) {
                    controller.doctorHospital.value = hospital!;
                  },
                  decoration: InputDecoration(
                    hintText: controller.doctor == null
                        ? 'the School, where you work'.tr
                        : null,
                    labelStyle: TextStyle(fontSize: 15, color: Colors.black87),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Styles.secondaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Styles.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                  ),
                  cursorColor: Styles.primaryColor,
                ),
                SizedBox(height: 20),
                TextFormField(
                  maxLines: null,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    node.nextFocus();
                  },
                  onSaved: (shortBiography) {
                    controller.shortBiography.value = shortBiography!;
                  },
                  initialValue: controller.doctor == null
                      ? null
                      : controller.shortBiography.value,
                  decoration: InputDecoration(
                    hintText:
                        controller.doctor == null ? 'Short Biography'.tr : null,
                    labelStyle: TextStyle(fontSize: 15, color: Colors.black87),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Styles.secondaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Styles.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                  ),
                  cursorColor: Styles.primaryColor,
                ),
                SizedBox(height: 20),
                TextFormField(

                  readOnly:true,
                  maxLines: null,
                  initialValue: controller.about.value ?? '',
                  decoration: InputDecoration(
                    hintText:
                    controller.about.value == '' ? 'video about course'.tr : 'video about course'.tr,
                    labelStyle: TextStyle(fontSize: 15, color: Colors.black87),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Styles.secondaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Styles.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Styles.primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.handle();
                      },
                      icon: Icon(Icons.upload),
                    ),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                  ),
                  cursorColor: Styles.primaryColor,
                ),
                SizedBox(height: 20),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: Colors.grey.shade100,
                  ),
                  onPressed: () {
                    Get.to(() => ChoseTeacherCategoryPage());
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Expanded(
                          child: Text(
                        controller.doctorCategory == null
                            ? 'Chose Teacher Category'.tr
                            : controller.doctorCategory!.categoryName!,
                        style: TextStyle(color: Styles.primaryColor),
                      )),
                      Icon(Icons.arrow_forward_ios,
                          color: Styles.secondaryColor),
                    ],
                  ),
                ),
                Divider(
                  height: 40,
                ),
                submitButton(
                    onTap: () {
                      controller.saveDoctorDetail();
                    },
                    text: 'Save'.tr)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
