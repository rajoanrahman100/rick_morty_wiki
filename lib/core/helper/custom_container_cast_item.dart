import 'package:flutter/material.dart';
import 'package:ricky_morty_wiki/core/constants/app_colors.dart';

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gradient = LinearGradient(
      colors: [
        AppColors.gdYellowGreen,
        AppColors.gdBluishCyan,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    var paint = Paint()
      //..color = Colors.black // Set border color here
      ..shader = shader
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    var path = getPath(size);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class AngledBottomRightCorner extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = getPath(size);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

  getPath(Size size) {
    var path = Path();
    path.lineTo(0, size.height); // Move to bottom left
    path.lineTo(size.width - (size.width / 6), size.height); // Line to start of angle
    path.lineTo(size.width, size.height - (size.height / 6)); // Diagonal line up to create angle
    path.lineTo(size.width, 0); // Line to top right

    path.close();
    return path;
  }
