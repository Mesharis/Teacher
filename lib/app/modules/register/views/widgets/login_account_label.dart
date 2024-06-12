import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../styles/styles.dart';

Widget loginAccountLabel({required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Already have an account ?'.tr,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black54),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Login'.tr,
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
