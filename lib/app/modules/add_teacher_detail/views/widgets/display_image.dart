import 'package:flutter/material.dart';

import '../../../../styles/styles.dart';

class DisplayImage extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;
  const DisplayImage(
      {super.key, required this.imagePath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final color = Color.fromRGBO(64, 105, 225, 1);
    return Center(
      child: Stack(
        children: [
          buildImage(color),
          Positioned(
            child: buildEditIcon(color),
            right: 8,
            top: 105,
          )
        ],
      ),
    );
  }

  // Builds Profile Image
  Widget buildImage(Color color) {
    final image = imagePath.isNotEmpty
        ? NetworkImage(imagePath)
        : AssetImage(
            'assets/images/default-profile.png',
          );

    return CircleAvatar(
      radius: 74,
      backgroundColor: Styles.primaryColor,
      child: CircleAvatar(
        backgroundImage: image as ImageProvider,
        radius: 70,
      ),
    );
  }

  // Builds Edit Icon on Profile Picture
  Widget buildEditIcon(Color color) => buildCircle(
        all: 0.1,
        child: Icon(Icons.edit, size: 16, color: Styles.secondaryColor),
      );

  // Builds/Makes Circle for Edit Icon on Profile Picture
  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Styles.primaryColor,
          ),
          child: child,
        ),
      );
}
