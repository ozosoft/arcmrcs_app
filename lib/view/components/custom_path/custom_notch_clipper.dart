import 'package:flutter/material.dart';

class NotchClipper extends CustomClipper<Path> {
  final double space;

  NotchClipper(this.space);

  @override
  Path getClip(Size size) {
    final path = Path();
    final halfWidth = size.width / 2;
    final halfSpace = space / 2;
    final curve = space / 6;
    final height = halfSpace / 1.2;
    path.lineTo(halfWidth - halfSpace, 0);
    path.cubicTo(halfWidth - halfSpace, 0, halfWidth - halfSpace + curve, height, halfWidth, height);

    path.cubicTo(halfWidth, height, halfWidth + halfSpace - curve, height, halfWidth + halfSpace, 0);

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

//Add this CustomPaint widget to the Widget Tree

class RPSCustomPainter3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double notchWidth = size.width * 0.2; // Adjust the width of the notch
    final double notchHeight = size.height * 0.1; // Adjust the height of the notch

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width * 0.5 + notchWidth / 2, size.height)
      ..lineTo(size.width * 0.5, size.height - notchHeight)
      ..lineTo(size.width * 0.5 - notchWidth / 2, size.height)
      ..lineTo(0, size.height)
      ..close();

    final paint = Paint()..color = Colors.white;
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width * 0.5, 0)
      ..lineTo(size.width * 0.35, size.height * 0.2)
      ..lineTo(size.width * 0.65, size.height * 0.2)
      ..close();

    final paint = Paint()..color = Colors.white;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.08241758, size.height * 0.01477105);
    path_0.cubicTo(size.width * 0.05207225, size.height * 0.01477105, size.width * 0.02747253, size.height * 0.02799749, size.width * 0.02747253,
        size.height * 0.04431315);
    path_0.lineTo(size.width * 0.02747253, size.height);
    path_0.lineTo(size.width * 0.9725275, size.height);
    path_0.lineTo(size.width * 0.9725275, size.height * 0.04431315);
    path_0.cubicTo(size.width * 0.9725275, size.height * 0.02799749, size.width * 0.9479286, size.height * 0.01477105, size.width * 0.9175824,
        size.height * 0.01477105);
    path_0.lineTo(size.width * 0.7197802, size.height * 0.01477105);
    path_0.cubicTo(size.width * 0.6646044, size.height * 0.01477105, size.width * 0.6250495, size.height * 0.04041462, size.width * 0.6011813,
        size.height * 0.06721832);
    path_0.cubicTo(size.width * 0.5799066, size.height * 0.09111817, size.width * 0.5425412, size.height * 0.1019202, size.width * 0.5000000,
        size.height * 0.1019202);
    path_0.cubicTo(size.width * 0.4574588, size.height * 0.1019202, size.width * 0.4200934, size.height * 0.09111817, size.width * 0.3988187,
        size.height * 0.06721832);
    path_0.cubicTo(size.width * 0.3749505, size.height * 0.04041462, size.width * 0.3353901, size.height * 0.01477105, size.width * 0.2802198,
        size.height * 0.01477105);
    path_0.lineTo(size.width * 0.08241758, size.height * 0.01477105);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
