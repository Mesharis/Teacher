import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/views/widgets/review_tile.dart';

import '../../../styles/styles.dart';
import '../../widgets/empty_list_widget.dart';
import '../controllers/review_controller.dart';

class ReviewView extends GetView<ReviewController> {
  const ReviewView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Review'.tr,
          style: Styles.appBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: controller.obx((listReview) {
        return controller.listReview.isNotEmpty
            ? Container(
                child: ListView.builder(
                    itemCount: controller.listReview.length,
                    itemBuilder: (context, index) {
                      return ReviewTile(
                          imgUrl: listReview![index].userReview!.photoUrl!,
                          name: listReview[index].userReview!.displayName!,
                          rating: listReview[index].rating!,
                          review: listReview[index].review!);
                    }))
            : Center(
                child: EmptyList(msg: 'no review'.tr),
              );
      }),
    );
  }
}
