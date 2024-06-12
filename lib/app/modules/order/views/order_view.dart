import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/empty_list_widget.dart';
import '../../../styles/styles.dart';
import '../controllers/order_controller.dart';

class OrderView extends GetView<OrderController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'My Appointments'.tr,
            style: Styles.appBarTextStyle,
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: Container(
          child: controller.obx(
            (listOrder) => ListView.builder(
              shrinkWrap: true,
              itemCount: listOrder!.length,
              itemBuilder: (builder, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Get.toNamed('/order-detail', arguments: listOrder[index]);
                    },
                    leading: const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/default-profile.png')
                                as ImageProvider),
                    title: Text('Appointment with '.tr +
                        listOrder[index].itemName),
                    subtitle: Text(
                      'at '.tr + listOrder[index].time,
                    ),
                    trailing: Wrap(
                      spacing: 5,
                      children: [Icon(Icons.arrow_forward_ios)],
                    ),
                  ),
                );
              },
            ),
            onEmpty: Center(
                child: EmptyList(
                    msg: 'you don\'t have Upcoming Appointment..!'.tr)),
          ),
        ));
  }
}
