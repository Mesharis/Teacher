import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Posts/views/posts_view.dart';
import '../../appointment/views/appointment_view.dart';
import '../../home/views/home_view.dart';
import '../../list_chat/views/list_chat_view.dart';
import '../../order/views/order_view.dart';
import '../../profile/views/profile_view.dart';
import '../../../styles/styles.dart';
import '../../../utils/icons/MyIcons_icons.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  final List<Widget> bodyContent = [
    HomeView(),
    AppointmentView(),
    OrderView(),
    PostsView(),
    ListChatView(),
    ProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Center(
            child: IndexedStack(
                index: controller.selectedIndex, children: bodyContent),
          )),
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          child: Container(
            margin: EdgeInsets.only(left: 12.0, right: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  //update the bottom app bar view each time an item is clicked
                  onPressed: () {
                    controller.updateTabSelection(0);
                  },
                  iconSize: 27,
                  icon: Icon(
                    MyIcons.home_2,
                    //darken the icon if it is selected or else give it a different color
                    color: controller.selectedIndex == 0
                        ? Styles.secondaryColor
                        : Colors.grey.shade400,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.activateTabAppointment();
                  },
                  iconSize: 27.0,
                  icon: Icon(
                    MyIcons.calendar_add,
                    color: controller.selectedIndex == 1
                        ? Styles.secondaryColor
                        : Colors.grey.shade400,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.updateTabSelection(2);
                    controller.initTabOrder();
                  },
                  iconSize: 27.0,
                  icon: Icon(
                    MyIcons.calendar_tick,
                    color: controller.selectedIndex == 2
                        ? Styles.secondaryColor
                        : Colors.grey.shade400,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.updateTabSelection(3);
                  },
                  iconSize: 27.0,
                  icon: Icon(
                    Icons.newspaper,
                    color: controller.selectedIndex == 3
                        ? Styles.secondaryColor
                        : Colors.grey.shade400,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.updateTabSelection(4);
                    //controller.initTabOrder();
                  },
                  iconSize: 27.0,
                  icon: Icon(
                    MyIcons.message,
                    color: controller.selectedIndex == 4
                        ? Styles.secondaryColor
                        : Colors.grey.shade400,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.updateTabSelection(5);
                  },
                  iconSize: 27.0,
                  icon: Icon(
                    MyIcons.profile,
                    color: controller.selectedIndex == 5
                        ? Styles.secondaryColor
                        : Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
