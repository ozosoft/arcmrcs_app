import 'package:flutter/material.dart';

class CustomDashedDivider extends StatelessWidget {
  final double height,width;

  const CustomDashedDivider({super.key, required this.height, required this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: CustomPaint(
        painter: DashedDividerPainter(),
      ),
    );
  }
}

class DashedDividerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey // Adjust the color of the dashed line as needed
      ..strokeWidth = 2 // Adjust the thickness of the dashed line as needed
      ..strokeCap = StrokeCap.square;

    final double dashWidth = 4;
    final double dashSpace = 5;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
