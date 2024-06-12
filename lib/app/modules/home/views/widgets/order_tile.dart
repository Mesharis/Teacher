import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../styles/styles.dart';
import '../../../../utils/timeformat.dart';

class OrderTile extends StatelessWidget {
  const OrderTile(
      {super.key,
      required this.name,
      required this.dateOrder});
  final String name;
  final DateTime dateOrder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      height: 68,
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
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Styles.whiteGreyColor,
              image: DecorationImage(
                image: AssetImage('assets/images/default-profile.png'),
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
                        TimeFormat().formatDate(dateOrder.toLocal()),
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
