//
import 'package:cached_network_image/cached_network_image.dart';
//
import 'package:flutter/material.dart';
//
import 'package:flutter/services.dart';
//
import 'package:get/get.dart';
//
import 'package:hallo_doctor_doctor_app/app/styles/styles.dart';
//
import 'package:hallo_doctor_doctor_app/app/utils/icons/MyIcons_icons.dart';
//
import '../controllers/profile_controller.dart';
//
import 'widgets/profile_button.dart';
import 'widgets/profile_cal_switch.dart';
//

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account'.tr,
          style: Styles.appBarTextStyle,
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).scaffoldBackgroundColor,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: GetX<ProfileController>(
                  builder: (_) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 58,
                          backgroundColor: Styles.primaryColor,
                          child: CircleAvatar(
                              radius: 55,
                              backgroundImage: controller.photoUrl.value.isEmpty
                                  ? null
                                  : CachedNetworkImageProvider(
                                      controller.photoUrl.value)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.user!.displayName!,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              controller.user?.email ?? "",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            )
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
            GetBuilder<ProfileController>(
              builder: (_) {
                return Visibility(
                  visible: !controller.isAccountActivated,
                  child: InkWell(
                    onTap: () {
                      Get.log(controller.isAccountActivated.toString());
                    },
                    child: Container(
                        height: 30,
                        color: Colors.red[300],
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Your account is still not activated'.tr,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )),
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            ProfileButton(
              onTap: () {
                controller.toEditProfile();
              },
              icon: MyIcons.profile,
              text: 'Edit Account'.tr,
            ),
            ProfileButton(
              onTap: () {
                controller.toEditDoctorDetail();
              },
              icon: MyIcons.edit,
              text: 'Edit Teacher Data'.tr,
            ),
            ProfileButton(
              onTap: () {
                controller.toBalance();
              },
              icon: MyIcons.wallet_3,
              text: 'Balance'.tr,
            ),
            GetBuilder<ProfileController>(
              init: ProfileController(),
              initState: (_) {},
              builder: (_) {
                return ProfileCallSwitch(
                  onTap: () async => await controller
                      .editAvailability(controller.availableForCall),
                  onChanged: (val) async => await controller
                      .editAvailability(controller.availableForCall),
                  icon: Icons.phone_in_talk_rounded,
                  text: 'Available for call'.tr,
                  isAvailableForCall: controller.availableForCall,
                  description: "enable to receive student calls".tr,
                  //controller.availableForCall,
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            ProfileButton(
              onTap: () {
                controller.logout();
              },
              icon: MyIcons.undo,
              text: 'Logout'.tr,
              hideArrowIcon: true,
            ),
            //test button, you can delete it
            // ElevatedButton(
            //     onPressed: () {
            //       controller.test();
            //     },
            //     child: Text('test'))
          ],
        ),
      ),
    );
  }
}
