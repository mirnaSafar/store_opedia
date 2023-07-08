// import 'package:flutter/material.dart';

// class BottomNavShadowPainter extends CustomPainter {
//   final Shadow shadow;
//   final CustomClipper<Path> clipper;
//   BottomNavShadowPainter({
//     required this.shadow,
//     required this.clipper,
//   });
//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = shadow.toPaint();
//     var clipPath = clipper.getClip(size).shift(shadow.offset);

//     canvas.drawPath(clipPath, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

// @override
// bool shouldRepaint(CustomPainter oldDelegate) {
//   return true;
// }

// class BottomNavClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path0 = Path();
//     path0.moveTo(0, size.height * 0.0150000);
//     path0.lineTo(size.width * 0.3675000, size.height * 0.0150000);
//     path0.quadraticBezierTo(size.width * 0.3703125, size.height * 0.6952500,
//         size.width * 0.4897500, size.height * 0.7520000);
//     path0.quadraticBezierTo(size.width * 0.6181875, size.height * 0.7385000,
//         size.width * 0.6150000, size.height * 0.0200000);
//     path0.lineTo(size.width, size.height * 0.0080000);
//     path0.lineTo(size.width * 0.9937500, size.height * 0.9800000);
//     path0.lineTo(size.width * 0.0037500, size.height * 0.9650000);
//     return path0;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => true;
// }

import 'package:flutter/material.dart';

class BottomNavShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;
  BottomNavShadowPainter({
    required this.shadow,
    required this.clipper,
  });
  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);

    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

@override
bool shouldRepaint(CustomPainter oldDelegate) {
  return true;
}

class BottomNavClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()..moveTo(0, 0);
    path.quadraticBezierTo(size.width * 0.0, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 10);
    path.arcToPoint(Offset(size.width * 0.60, 10),
        radius: const Radius.circular(10.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
