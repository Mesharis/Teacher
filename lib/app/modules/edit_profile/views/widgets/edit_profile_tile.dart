import 'package:flutter/material.dart';
import '../../../../styles/styles.dart';

class EditProfileTile extends StatelessWidget {
  const EditProfileTile({super.key, this.title, this.subtitle, this.onTap});

  final String? title;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black12),
        ),
        margin: EdgeInsets.only(bottom: 5, right: 10, left: 10),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
              start: 15, end: 5, bottom: 10, top: 10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title ?? '',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w400)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      subtitle ?? '',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                      maxLines: 2,
                    )
                  ],
                ),
              ),
              onTap == null
                  ? SizedBox.shrink()
                  : Padding(
                      padding: EdgeInsetsDirectional.only(end: 10),
                      child: Icon(
                        Icons.edit,
                        size: 21,
                        color: Styles.primaryColor,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
