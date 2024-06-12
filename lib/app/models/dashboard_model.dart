import 'review_dart.dart';
import 'timeslot_model.dart';

class DashboardModel {
  DashboardModel({this.balance, this.listReview, this.listAppointment});

  int? balance;
  List<OrderModel>? listAppointment;
  List<ReviewModel>? listReview;
}
