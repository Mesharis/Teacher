import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../services/notification_service.dart';
import '../../../services/user_service.dart';
import '../../appointment/controllers/appointment_controller.dart';
import '../../order/controllers/order_controller.dart';

class DashboardController extends GetxController {
  final _selectedIndex = 0.obs;
  get selectedIndex => _selectedIndex.value;
  set selectedIndex(index) => _selectedIndex.value = index;
  NotificationService notificationService = Get.find<NotificationService>();

  @override
  void onInit() async {
    super.onInit();
    EasyLoading.show();
    notificationService.listenNotification();
    await UserService().updateUserToken(await notificationService.getNotificationToken());
    EasyLoading.dismiss();
  }

  @override
  void onClose() {}

  void initTabAppointment() {
    Get.find<AppointmentController>().initDoctorSchedule();
  }

  void initTabOrder() {
    Get.find<OrderController>().initOrderedTimeSlot();
  }

  void activateTabAppointment() {
    initTabAppointment();
    updateTabSelection(1);
  }

  void activateTabOrder() {
    initTabOrder();
    updateTabSelection(2);
  }

  void updateTabSelection(int index) {
    selectedIndex = index;
  }
}
