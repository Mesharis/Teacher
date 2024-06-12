// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) => Doctor(
      doctorId: json['doctorId'] as String?,
      doctorName: json['doctorName'] as String?,
      about: json['about'] ?? '',
      doctorPicture: json['doctorPicture'] as String?,
      doctorPrice: json['doctorBasePrice'] as int?,
      doctorShortBiography: json['doctorBiography'] as String?,
      doctorCategory: json['doctorCategory'] == null
          ? null
          : DoctorCategory.fromJson(
              json['doctorCategory'] as Map<String, dynamic>),
      doctorHospital: json['doctorHospital'] as String?,
      doctorBalance: json['balance'] as int?,
      accountStatus: json['accountStatus'] as String?,
      doctorUserId: json['doctorUserId'] as String?,
      availableForCall: json['availableForCall'] as bool?,
    );

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'doctorId': instance.doctorId,
      'doctorUserId': instance.doctorUserId,
      'availableForCall': instance.availableForCall,
      'doctorName': instance.doctorName,
      'doctorPicture': instance.doctorPicture,
      'doctorBasePrice': instance.doctorPrice,
      'about': instance.about,
      'doctorBiography': instance.doctorShortBiography,
      'doctorCategory': instance.doctorCategory,
      'doctorHospital': instance.doctorHospital,
      'balance': instance.doctorBalance,
      'accountStatus': instance.accountStatus,
    };
