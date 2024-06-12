import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../dashboard/controllers/dashboard_controller.dart';
import 'widgets/order_tile.dart';
import 'widgets/profile_picture_circle.dart';
import 'widgets/review_tile.dart';
import '../../widgets/empty_list_widget.dart';
import '../../widgets/section_title.dart';
import '../../../routes/app_pages.dart';
import '../../../styles/styles.dart';
import '../../../utils/constants.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark, // navigation bar color
      statusBarColor:
          Theme.of(context).scaffoldBackgroundColor, // status bar color
    ));
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
        child: controller.obx(
          (dahsboardData) => Column(
            children: [
              Container(
                width: double.infinity,
                child: Obx(
                  () => Row(
                    children: [
                      profilePictureCircle(controller.profilePic.value),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Hello '.tr + controller.username.value,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Welcome Back!'.tr,
                            style: TextStyle(
                                fontSize: 14, color: Styles.greyTextColor),
                          )
                        ],
                      ),
                      Spacer(),
                      Image.asset(
                        "assets/images/app_svg.png",
                        width: 70,
                        height: 70,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 150,
                padding: EdgeInsets.only(top: 20, bottom: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x10000000),
                        blurRadius: 10,
                        spreadRadius: 4,
                        offset: Offset(0.0, 8.0))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Current Balance'.tr,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        controller.balance == 0
                            ? Row(
                                children: [
                                  Text("0",
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w400,
                                          color: Styles.secondaryColor)),
                                  Text(" "),
                                  Text(
                                    currencySign,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Styles.secondaryColor,
                                    ),
                                  )
                                ],
                              )
                            : Row(
                                children: [
                                  Text(
                                    controller.balance.toString(),
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w400,
                                      color: Styles.secondaryColor,
                                    ),
                                  ),
                                  Text(" "),
                                  Text(
                                    currencySign,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Styles.secondaryColor,
                                    ),
                                  )
                                ],
                              ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    VerticalDivider(),
                    Column(
                      children: [
                        Text(
                          'Appointment made'.tr,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Styles.secondaryColor,
                          ),
                        ),
                        Text(
                          'this month'.tr,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Styles.greyTextColor,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SectionTitle(
                title: 'Upcoming Appointment'.tr,
                subTitle: 'See More'.tr,
                onPressed: () {
                  Get.find<DashboardController>().activateTabOrder();
                },
              ),
              Container(
                  height: 200,
                  child: dahsboardData!.listAppointment!.isNotEmpty
                      ? ListView.builder(
                          itemCount: dahsboardData.listAppointment!.length,
                          itemBuilder: (contex, index) => OrderTile(
                            name: dahsboardData.listAppointment![index].username,
                            dateOrder: DateFormat("yyyy-MM-dd HH:mm").parse(dahsboardData.listAppointment![index].time),
                          ),
                        )
                      : EmptyList(
                          msg: "you don't have Upcoming Appointment..!".tr)),
              SectionTitle(
                title: 'Review'.tr,
                subTitle: 'See More'.tr,
                onPressed: () {
                  Get.toNamed(Routes.REVIEW);
                },
              ),
              Container(
                  height: 200,
                  width: Get.width,
                  child: dahsboardData.listReview!.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: dahsboardData.listReview!.length,
                          itemBuilder: (contex, index) => ReviewTile(
                                name: dahsboardData.listReview![index]
                                        .userReview!.displayName ??
                                    "",
                                imgUrl: dahsboardData.listReview![index]
                                        .userReview!.photoUrl ??
                                    '',
                                rating:
                                    dahsboardData.listReview![index].rating!,
                                review:
                                    dahsboardData.listReview![index].review ??
                                        '',
                              ))
                      : EmptyList(msg: 'no review'.tr)),
            ],
          ),
        ),
      ),
    )));
  }
}
