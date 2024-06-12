import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../models/withdraw_method_model.dart';
import '../../../models/withdraw_settings_detail.dart';
import '../views/pages/password_confimation_page.dart';
import '../../../services/withdraw_service.dart';
import '../../../utils/exceptions.dart';

class WithdrawDetailController extends GetxController {

  final count = 0.obs;
  var pass = ''.obs;
  WithdrawMethod withdrawMethod = Get.arguments[0]['withdrawMethod'];
  int amount = Get.arguments[0]['amount'];
  WithdrawSettingsDetail? withdrawSettingsDetail;
  double? total;
  double? percentageCut;
  double? percentageTaxCut;
  @override
  void onInit() async {
    super.onInit();
    withdrawSettingsDetail = await WithdrawService().getWithdrawSettings();
    percentageCut = ((amount / 100) * withdrawSettingsDetail!.percentage!);
    percentageTaxCut = ((amount / 100) * withdrawSettingsDetail!.tax!);
    total = amount - (percentageCut! + percentageTaxCut!);
    update();
    EasyLoading.dismiss();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  requestWithdraw() {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    print('password : ${pass.value}');
    WithdrawService()
        .requestWithdraw(pass.value, withdrawMethod, amount)
        .then((value) {
      Get.offNamedUntil('/withraw-finish', ModalRoute.withName('/balance'));
      pass.value = '';
    }).catchError((err) {
      exceptionToast(err.toString());
    }).whenComplete(() => EasyLoading.dismiss());
  }

  toPasswordConfirmation() {
    if (amount <= 0) {
      return Get.defaultDialog(
        title: '',
        titleStyle: TextStyle(),
        content: Text('your balance is not sufficient to withdraw'.tr),
      );
    }
    Get.to(() => PasswordConfirmationPage());
  }
}
