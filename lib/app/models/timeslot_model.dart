import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_model.dart';

class TimeSlot {
  TimeSlot(
      {this.timeSlotId,
      this.timeSlot,
      this.pastTimeSlot,
      this.duration,
      this.price,
      this.available,
      this.doctorid,
      this.bookByWho,
      this.purchaseTime,
      this.status,
      this.link,
      this.parentTimeslotId});
  static const String _timeSlotId = 'timeSlotId';
  static const String _timeSlot = 'timeSlot';
  static const String _duration = 'duration';
  static const String _price = 'price';
  static const String _available = 'available';
  static const String _doctorId = 'doctorId';
  static const String _bookByWho = 'bookByWho';
  static const String _purchaseTime = 'purchaseTime';
  static const String _status = 'status';
  static const String _pastTimeSlot = 'pastTimeSlot';
  static const String _parentTimeslotId = 'parentTimeslotId';
  static const String _link = 'link';

  String? timeSlotId;
  DateTime? timeSlot;
  DateTime? pastTimeSlot;
  int? duration;
  int? price;
  bool? available;
  String? doctorid;
  String? link;
  UserModel? bookByWho;
  DateTime? purchaseTime;
  String? status;
  List<DateTime>? repeatTimeSlot;
  String? parentTimeslotId;

  factory TimeSlot.fromJson(Map<String, dynamic> jsonData) {
    return TimeSlot(
        timeSlotId: jsonData[_timeSlotId],
        link: jsonData[_link] ?? '',
        timeSlot: (jsonData[_timeSlot] as Timestamp).toDate().toLocal(),
        pastTimeSlot: jsonData[_pastTimeSlot] != null
            ? (jsonData[_pastTimeSlot] as Timestamp).toDate().toLocal()
            : null,
        duration: jsonData[_duration],
        price: jsonData[_price],
        available: jsonData[_available],
        doctorid: jsonData[_doctorId],
        bookByWho: jsonData[_bookByWho] != null
            ? UserModel.fromJson(jsonData[_bookByWho])
            : null,
        purchaseTime: jsonData[_purchaseTime] != null
            ? (jsonData[_purchaseTime] as Timestamp).toDate()
            : null,
        status: jsonData[_status],
        parentTimeslotId: jsonData[_parentTimeslotId]);
  }

  Map<String, dynamic> toMap(TimeSlot timeSlot) {
    if (timeSlot.timeSlot == null) {
      return {
        _duration: timeSlot.duration,
        _price: timeSlot.price,
        _link: timeSlot.link,
        _available: timeSlot.available,
        _doctorId: timeSlot.doctorid,
        _parentTimeslotId: timeSlot.parentTimeslotId
      };
    } else {
      return {
        _timeSlot: Timestamp.fromDate(timeSlot.timeSlot!.toUtc()),
        _duration: timeSlot.duration,
        _price: timeSlot.price,
        _link: timeSlot.link,
        _available: timeSlot.available,
        _doctorId: timeSlot.doctorid,
        _parentTimeslotId: timeSlot.parentTimeslotId
      };
    }
  }
}



class OrderModel {
  OrderModel({
    required this.itemId,
    required this.itemName,
    required this.time,
    required this.link,
    required this.duration,
    required this.price,
    required this.doctorId,
    required this.userId,
    required this.orderId,
    required this.username,
  });
  static const String _itemId = 'itemId';
  static const String _itemName = 'itemName';
  static const String _time = 'time';
  static const String _link = 'link';
  static const String _duration = 'duration';
  static const String _price = 'price';
  static const String _doctorId = 'doctorId';
  static const String _userId = 'userId';
  static const String _orderId = 'orderId';
  static const String _username = 'username';

  final String itemId;
  final String itemName;
  final String time;
  final List<String> link;
  final String duration;
  final String price;
  final String doctorId;
  final String userId;
  final String orderId;
  final String username;

  factory OrderModel.fromJson(Map<String, dynamic> jsonData) {
    return OrderModel(
      itemId:  jsonData[_itemId],
      itemName:jsonData[_itemName],
      time: jsonData[_time],
      link: List.from(jsonData[_link] ?? []),
      duration:jsonData[_duration],
      price: jsonData[_price],
      doctorId: jsonData[_doctorId],
      userId: jsonData[_userId],
      orderId: jsonData[_orderId],
      username: jsonData[_username],
    );
  }

  Map<String, dynamic> toMap(OrderModel order) {
    return {
     _itemId: order.itemId,
     _itemName: order.itemName,
     _time: order.time,
     _link: order.link,
     _duration: order.duration,
     _price: order.price,
     _doctorId: order.doctorId,
     _userId: order.userId,
     _orderId: order.orderId,
     _username: order.username,
    };
  }
}
