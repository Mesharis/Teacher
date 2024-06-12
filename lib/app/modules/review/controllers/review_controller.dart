import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../models/doctor_model.dart';
import '../../../models/review_dart.dart';
import '../../../services/doctor_service.dart';
import '../../../services/review_service.dart';

class ReviewController extends GetxController
    with StateMixin<List<ReviewModel>> {

  final count = 0.obs;
  List<ReviewModel> listReview = [];
  @override
  void onInit() async {
    super.onInit();
    EasyLoading.show();
    try {
      Doctor? doctor = await DoctorService().getDoctor();
      if (doctor != null) {
        listReview = await ReviewService().getListReview(doctor);
        change(listReview, status: RxStatus.success());
      } else {
        change([], status: RxStatus.error());
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }



  void increment() => count.value++;
}
