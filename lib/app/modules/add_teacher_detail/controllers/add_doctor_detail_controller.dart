import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/doctor_category.dart';
import '../../../models/doctor_model.dart';
import '../../../services/doctor_category_service.dart';
import '../../../services/doctor_service.dart';
import '../../../services/user_service.dart';
import '../../../utils/exceptions.dart';
import '../views/pages/edit_image_page.dart';

class AddTeacherDetailController extends GetxController
    with StateMixin<List<DoctorCategory>> {
  final count = 0.obs;

  var formkey = GlobalKey<FormState>();
  var doctorName = ''.obs;
  var doctorHospital = ''.obs;
  var shortBiography = ''.obs;
  var about = ''.obs;
  String? url;
  DoctorCategory? doctorCategory;
  Doctor? doctor = Get.arguments;
  var profilePicUrl = ''.obs;
  bool isEdit = false;
  @override
  void onInit() {
    super.onInit();
    if (doctor != null) {
      isEdit = true;
      profilePicUrl.value = doctor!.doctorPicture!;
      doctorName.value = doctor!.doctorName!;
      doctorHospital.value = doctor!.doctorHospital!;
      shortBiography.value = doctor!.doctorShortBiography!;
      doctorCategory = doctor!.doctorCategory!;
      about.value = doctor!.about!;
      update();
    }
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  void updateProfilePic(File filePath) {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    UserService().updatePhoto(filePath).then((imgUrl) {
      profilePicUrl.value = imgUrl;
      Get.back();
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: error.toString(), toastLength: Toast.LENGTH_LONG);
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

  void toEditProfilePic() {
    Get.to(() => EditImagePage());
  }

  void initDoctorCategory() {
    DoctorCategoryService().getListDoctorCategory().then((doctorCategory) {
      change(doctorCategory, status: RxStatus.success());
    });
  }

  void saveDoctorDetail() async {
    if (profilePicUrl.value.isEmpty) {
      exceptionToast('Please choose your profile photo'.tr);
      return;
    }
    if (doctorCategory == null) {
      exceptionToast('Please chose teacher Specialty or Category'.tr);
      return;
    }
    if (formkey.currentState!.validate() && doctorCategory != null) {
      formkey.currentState!.save();
      EasyLoading.show(
          status: 'loading...'.tr, maskType: EasyLoadingMaskType.black);
      try {
        await DoctorService().saveDoctorDetail(
            doctorName: doctorName.value,
            hospital: doctorHospital.value,
            shortBiography: shortBiography.value,
            pictureUrl: profilePicUrl.value,
            doctorCategory: doctorCategory!,
            about: about.value,
            isUpdate: isEdit
        );
        Get.offNamed('/dashboard');
        EasyLoading.dismiss();
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
        EasyLoading.dismiss();
      }
    }
  }

  Future<String?> video({required String folderName, required XFile?  link})  async {
    firebase_storage.UploadTask uploadTask;
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref();
    final metadata = firebase_storage.SettableMetadata(contentType: 'VIDEO/MP4', customMetadata: {'picked-file-path': link!.path});
    uploadTask = ref.child(folderName).child('/${Random().nextInt(999)}VIDEO.mp4').putFile(File(link.path),metadata);
    String url = await (await uploadTask).ref.getDownloadURL();
    return url;
  }


  void handle() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? media = await picker.pickVideo(source: ImageSource.gallery);
      if (media != null) {
        EasyLoading.show(maskType: EasyLoadingMaskType.black);
        url = await video(folderName: doctorName.value, link: media);
        about.value = url!;
        EasyLoading.dismiss();
      }
    } catch (err) {
      Fluttertoast.showToast(
          msg: err.toString(), toastLength: Toast.LENGTH_LONG);
      rethrow;
    }
  }
}
