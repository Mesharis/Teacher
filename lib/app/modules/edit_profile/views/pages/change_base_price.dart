import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../styles/styles.dart';
import '../../../login/views/widgets/submit_button.dart';
import '../../controllers/edit_profile_controller.dart';

class ChangeBasePrice extends GetView<EditProfileController> {
  const ChangeBasePrice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Change Base Price'.tr,
          style: Styles.appBarTextStyle,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: controller.textEditingBasePriceController,
              decoration: InputDecoration(
                hintText: 'Base Price'.tr,
                helperText: 'Your Base Booking Price'.tr,
                labelText: 'Base Price'.tr,
                prefixText: ' ',
                suffixStyle: const TextStyle(color: Colors.green),
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
            SizedBox(
              height: 10,
            ),
            submitButton(
                onTap: () {
                  controller.saveBasePrice();
                },
                text: 'Save'.tr),
            // Container(
            //   child: ElevatedButton(
            //     onPressed: () {
            //       controller.saveBasePrice();
            //     },
            //     child: Text('Save'.tr,
            //         style: TextStyle(color: Styles.secondaryColor)),
            //     style: ElevatedButton.styleFrom(
            //       fixedSize: Size(340, 40),
            //       backgroundColor: Styles.primaryColor,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
