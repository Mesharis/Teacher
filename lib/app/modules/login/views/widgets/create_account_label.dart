import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../styles/styles.dart';

Widget createAccountLabel(VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?'.tr,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black54),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'Register'.tr,
            style: TextStyle(
                color: Styles.primaryColor,
                fontSize: 17,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    ),
  );
}
