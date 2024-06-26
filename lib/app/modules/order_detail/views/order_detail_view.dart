import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../styles/styles.dart';
import '../../../utils/constants.dart';
import '../controllers/order_detail_controller.dart';
import 'widgets/user_order_tile.dart';

class OrderDetailView extends GetView<OrderDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: Text(
          'Order Detail'.tr,
          style: Styles.appBarTextStyle,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        actions: [
          //list if widget in appbar actions
//          PopupMenuButton(
//             color: Colors.white,
//             itemBuilder: (context) => [
//               PopupMenuItem<int>(
//                 value: 0,
//                 child: Text(
//                   'Cancel Appointment'.tr,
//                 ),
//               ),
//             ],
//             onSelected: (int item) => {
//               if (item == 0)
//                 {
//                   //cancel appointment click
//                   Get.defaultDialog(
//                       title: 'Cancel Appointment'.tr,
//                       content: Text(
//                         'are you sure you want to cancel this appointment'.tr,
//                         textAlign: TextAlign.center,
//                       ),
//                       onCancel: () {},
//                       onConfirm: () {
//                         if (controller.orderedTimeslot.status == 'booked') {
//                           Get.back();
//                           controller.cancelAppointment();
//                         }
//                         if (controller.orderedTimeslot.status == 'refund') {
//                           Fluttertoast.showToast(
//                               msg:
//                                   'the appointment has been previously canceled'
//                                       .tr);
//                           Get.back();
//                         }
//                         if (controller.orderedTimeslot.status == 'complete') {
//                           Fluttertoast.showToast(
//                               msg:
//                                   'The meeting has started and can\'t be canceled anymore'
//                                       .tr);
//                           Get.back();
//                         }
//                       })
//                 }
//             },
//           ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  'Appointment with'.tr,
                  style: Styles.appointmentDetailTextStyle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              UserOrderTile(
                  name: controller.orderedTimeslot.username,
                  orderTime: DateFormat("yyyy-MM-dd HH:mm").parse(controller.orderedTimeslot.time!)),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  'Appointment Detail'.tr,
                  style: Styles.appointmentDetailTextStyle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8),
                height: 500,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0x04000000),
                          blurRadius: 10,
                          spreadRadius: 10,
                          offset: Offset(0.0, 8.0))
                    ],
                    color: Colors.white),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Table(
                      children: [
                        TableRow(children: [
                          SizedBox(
                              height: 50, child: Text('Appointment Time'.tr)),
                          SizedBox(
                            height: 50,
                            child: Text(controller.orderedTimeslot.time!),
                          )
                        ]),
                       TableRow(children: [
                                SizedBox(
                                    height: 50,
                                    child: Text('Reschedule From'.tr)),
                                SizedBox(
                                  height: 50,
                                  child: Text(controller
                                      .orderedTimeslot.time!),
                                )
                              ]),
                        TableRow(children: [
                          SizedBox(height: 50, child: Text('Duration'.tr)),
                          SizedBox(
                              height: 50,
                              child: Text(
                                  ': ${controller.orderedTimeslot.duration}${' Minute'.tr}')),
                        ]),
                        TableRow(children: [
                          SizedBox(height: 50, child: Text('Price'.tr)),
                          SizedBox(
                            height: 50,
                            child: Text(
                              currencySign +
                                  controller.orderedTimeslot.price.toString() +
                                  ' (Paid)'.tr,
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          SizedBox(
                            height: 50,
                            child: Text('Meet link'.tr),
                          ),
                          Column(
                            children:
                            controller.orderedTimeslot.link.map((e) {
                              return InkWell(
                                onTap: () {
                                  if (e.isNotEmpty) {
                                    final Uri uri = Uri.parse(e);
                                    launchUrl(uri);
                                    Clipboard.setData(ClipboardData(text: e));
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: 'error '.tr,
                                      toastLength: Toast.LENGTH_LONG,
                                    );
                                  }
                                },
                                child: Text('Click here'.tr),
                              );
                            }).toList(),
                          )
                        ]),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
