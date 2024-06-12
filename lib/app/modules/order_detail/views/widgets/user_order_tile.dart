import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../styles/styles.dart';
import '../../../../utils/timeformat.dart';
import '../../../widgets/network_image.dart';

class UserOrderTile extends StatelessWidget {
  const UserOrderTile({
    super.key,
    required this.name,
    required this.orderTime,
  });

  final String name;
  final DateTime orderTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      height: 68,
      width: double.infinity,
      alignment: Alignment.centerLeft,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 12,
          ),
      Container(
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Styles.whiteGreyColor,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: AppCashedImage(
            imageUrl: 'assets/images/default-profile.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                FittedBox(
                  child: Text(
                    'Order at : '.tr +
                        TimeFormat().formatDate(orderTime.toLocal()),
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.grey),
                    maxLines: 2,
                    softWrap: false,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }
}
