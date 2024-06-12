import 'timeslot_model.dart';
import 'user_model.dart';

class Order {
  TimeSlot timeSlot;
  UserModel orderByWho;
  Order({required this.timeSlot, required this.orderByWho});
}
