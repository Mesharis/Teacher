import 'package:get/get.dart';
import '../../../services/user_service.dart';
import '../../Posts/controllers/posts_controller.dart';
import '../../appointment/controllers/appointment_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../order/controllers/order_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserService>(() => UserService());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<AppointmentController>(() => AppointmentController());
    Get.lazyPut<OrderController>(() => OrderController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<PostsController>(() => PostsController());
  }
}
