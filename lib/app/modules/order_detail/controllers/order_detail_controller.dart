import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../models/timeslot_model.dart';
import '../../../services/timeslot_service.dart';
import '../../../services/videocall_service.dart';

class OrderDetailController extends GetxController {
  OrderModel orderedTimeslot = Get.arguments;

  @override
  void onInit() async {
    super.onInit();

  }

  @override
  void onClose() {}

}
