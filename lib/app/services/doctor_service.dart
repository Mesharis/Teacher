import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/doctor_category.dart';
import '../models/doctor_model.dart';
import '../models/user_model.dart';
import 'user_service.dart';

class DoctorService {
  static Doctor? doctor;
  set currentDoctor(Doctor? doctor) => DoctorService.doctor = doctor;

  Future saveDoctorDetail({required String doctorName,required String about, required String hospital, required String shortBiography, required String pictureUrl, required DoctorCategory doctorCategory, bool isUpdate = false}) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      CollectionReference doctors = FirebaseFirestore.instance.collection('Doctors');
      Map<String, dynamic> doctorsData = {
        'doctorName': doctorName,
        'doctorHospital': hospital,
        'doctorBiography': shortBiography,
        'doctorPicture': pictureUrl,
        'about': about,
        'availableForCall': false,
        'doctorCategory': {
          'categoryId': doctorCategory.categoryId,
          'categoryName': doctorCategory.categoryName
        },
        'doctorBasePrice': 10,
        'doctorUserId': auth.currentUser?.uid,
        'accountStatus': 'nonactive'
      };

      if (isUpdate) {
        doctorsData['updatedAt'] = FieldValue.serverTimestamp();
        await doctors.doc(DoctorService.doctor!.doctorId).update(doctorsData);
        await getDoctor(forceGet: true);
      } else {
        doctorsData['createdAt'] = FieldValue.serverTimestamp();
        doctorsData['updatedAt'] = FieldValue.serverTimestamp();
        var doctor = await doctors.add(doctorsData);
        UserService().setDoctorId(doctor.id);
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  ///get doctor, if current doctor is null will get from server
  ///[forceGet] if true will force get from server even if current doctor is not null
  Future<Doctor> getDoctor({bool forceGet = false}) async {
    try {
      if (DoctorService.doctor != null && forceGet == false) {
        return DoctorService.doctor!;
      }

      var doctorId = await UserService().getDoctorId();
      print('doctor id : $doctorId');
      var doctorReference = await FirebaseFirestore.instance.collection('Doctors').doc(doctorId).get();
      if (!doctorReference.exists) return null!;
      print('data doctor : ${doctorReference.data()}');
      var data = doctorReference.data() as Map<String, dynamic>;
      data['doctorId'] = doctorId;
      Doctor doctor = Doctor.fromJson(data);
      DoctorService.doctor = doctor;
      DoctorService().currentDoctor = doctor;
      return doctor;
    } catch (e) {
      return null!;
    }
  }
  Future<UserModel> getUser(user) async {
    try {
      var doctorReference = await FirebaseFirestore.instance.collection('Users').doc(user).get();
      if (!doctorReference.exists) return null!;
      print('data doctor : ${doctorReference.data()}');
      var data = doctorReference.data() as Map<String, dynamic>;
      data['uid'] = user;
      UserModel doctor = UserModel.fromJson(data);
      return doctor;
    } catch (e) {
      return null!;
    }
  }

  Future updateDoctorBasePrice(int basePrice) async {
    try {
      await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(doctor!.doctorId)
          .update({'doctorBasePrice': basePrice});
      doctor!.doctorPrice = basePrice;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<bool> updateDoctorAvailabilty({required bool available}) async {
    try {
      await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(doctor!.doctorId)
          .update({'availableForCall': available});
      doctor?.availableForCall = available;
      Get.log(
          "$available   ${doctor!.availableForCall}");
      return available;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
