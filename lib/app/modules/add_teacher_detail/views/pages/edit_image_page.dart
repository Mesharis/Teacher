import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../styles/styles.dart';
import '../../../login/views/widgets/submit_button.dart';
import '../../controllers/add_doctor_detail_controller.dart';

class EditImagePage extends GetView<AddTeacherDetailController> {
  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    XFile? image;
    File? imageFile;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Edit Image'.tr, style: Styles.appBarTextStyle,
          //style: appbarTextStyle,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
              width: double.infinity,
              child: Text(
                'Upload a photo of yourself '.tr,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54),
                textAlign: TextAlign.center,
              )),

          Padding(
            padding: EdgeInsets.only(top: 20),
            child: SizedBox(
              width: 330,
              child: GestureDetector(
                onTap: () async {
                  try {
                    image = await picker.pickImage(source: ImageSource.gallery);
                  } catch (e) {
                    print(e.toString());
                  }
                  if (image == null) return;
                  imageFile = File(image!.path);
                  controller.update();
                },
                child: GetBuilder<AddTeacherDetailController>(
                  builder: (_) {
                    if (image != null) {
                      return Image.file(
                        imageFile!,
                        height: 350,
                      );
                    } else {
                      return Image.asset('assets/images/default-profile.png');
                    }
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: submitButton(
                onTap: () {
                  if (imageFile == null) return;
                  controller.updateProfilePic(imageFile!);
                },
                text: 'Update'.tr),
          ),

          // Padding(
          //     padding: EdgeInsets.only(top: 40),
          //     child: Align(
          //         alignment: Alignment.bottomCenter,
          //         child: SizedBox(
          //           width: 330,
          //           height: 50,
          //           child: ElevatedButton(
          //             onPressed: () {
          //               if (imageFile == null) return;
          //               controller.updateProfilePic(imageFile!);
          //             },
          //             child: Text(
          //               'Update'.tr,
          //               style: TextStyle(fontSize: 15),
          //             ),
          //           ),
          //         )))
        ],
      ),
    );
  }
}
