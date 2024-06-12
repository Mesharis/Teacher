import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../services/auth_service.dart';
import '../../../services/doctor_service.dart';
import '../../../services/user_service.dart';
import '../../../styles/styles.dart';

import '../../../models/doctor_model.dart';

class ProfileController extends GetxController {
  var user = UserService().currentUser;
  bool tap = false;
  var photoUrl = ''.obs;
  var displayName = ''.obs;
  String accountStatus = 'nonactive';
  bool isAccountActivated = false;
  bool availableForCall = false;
  Doctor? doc;

  @override
  void onReady() async {
    super.onReady();
    photoUrl.value = await UserService().getPhotoUrl();

    doc = await DoctorService().getDoctor();
    print(availableForCall);
    accountStatus = doc?.accountStatus ?? "nonactive";
    if (accountStatus == 'active') {
      isAccountActivated = true;
      availableForCall = doc?.availableForCall ?? false;
    }

    Get.log(
      accountStatus +
          isAccountActivated.toString() +
          availableForCall.toString(),
    );
    update();
  }

  @override
  void onClose() {}

  void toEditProfile() {
    Get.toNamed('/edit-profile');
  }

  Future<void> editAvailability(bool available) async {
    Get.log(available.toString());
    doc = await DoctorService().getDoctor().then((value) async {
      availableForCall = await DoctorService().updateDoctorAvailabilty(
          available: value?.availableForCall == true ? false : true);

      return value;
    });
    update();
  }

  void toBalance() {
    Get.toNamed('/balance');
  }

  void toEditDoctorDetail() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    var doctor = DoctorService.doctor;
    EasyLoading.dismiss();
    Get.toNamed('/add-doctor-detail', arguments: doctor);
  }

  void logout() async {
    Get.defaultDialog(
      title: 'Logout'.tr,
      middleText: 'Are you sure you want to Logout'.tr,
      radius: 15,
      textCancel: 'Cancel'.tr,
      cancelTextColor: Colors.red,
      textConfirm: 'Logout'.tr,
      buttonColor: Styles.primaryColor,
      confirmTextColor: Styles.secondaryColor,
      onConfirm: () {
        AuthService().logout();
        Get.offAllNamed('/login');
      },
    );
  }

  void test() async {
    // //await ChatService().getListChat();
    // NotificationService().testNotification();
  }
}
