import 'package:flutter/material.dart';

import '../../styles/styles.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle(
      {super.key, required this.title, required this.subTitle, this.onPressed});
  final String title;
  final String subTitle;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        TextButton(
          child: Text(subTitle,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Styles.secondaryColor,
              )),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
