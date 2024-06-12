import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'widgets/transaction_tile.dart';
import '../../widgets/empty_list_widget.dart';
import '../../widgets/section_title.dart';
import '../../../styles/styles.dart';
import '../../../utils/constants.dart';

import '../controllers/balance_controller.dart';

enum TransactionType { withdraw, payment }

class BalanceView extends GetView<BalanceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Balance'.tr,
          style: Styles.appBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Column(
            children: [
              Container(
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
                child: Column(
                  children: [
                    Text(
                      'Current Balance'.tr,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.balance.value.toString(),
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 5),
                            Text(
                              currencySign,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 150,
                      child: ElevatedButton(
                        child: Text(
                          "Withdraw".tr,
                          style: TextStyle(color: Styles.secondaryColor),
                        ),
                        onPressed: () => controller.withdraw(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Styles.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SectionTitle(
                title: 'Last Transaction'.tr,
                subTitle: 'See all transaction'.tr,
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => controller.getTransaction(),
                  child: controller.obx(
                      (listTransaction) => ListView.separated(
                            shrinkWrap: true,
                            itemCount: listTransaction!.length,
                            itemBuilder: (contex, index) {
                              switch (TransactionType.values
                                  .byName(listTransaction[index].type!)) {
                                case TransactionType.payment:
                                  {
                                    return TransactionTile(
                                      type: 'Payment',
                                      status: listTransaction[index].status!,
                                      amount: listTransaction[index].amount!,
                                      dateCreate:
                                          listTransaction[index].createdAt!,
                                    );
                                  }

                                case TransactionType.withdraw:
                                  {
                                    return TransactionTile(
                                      type: 'Withdraw'.tr,
                                      status: listTransaction[index].status!,
                                      amount: listTransaction[index].amount!,
                                      dateCreate:
                                          listTransaction[index].createdAt!,
                                      method: listTransaction[index]
                                              .withdrawMethod!
                                              .method ??
                                          '',
                                      email: listTransaction[index]
                                              .withdrawMethod!
                                              .email ??
                                          '',
                                    );
                                  }
                              }
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 5,
                              );
                            },
                          ),
                      onEmpty: EmptyList(msg: 'No Transaction yet'.tr)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
