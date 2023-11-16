import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  const DashedLine(
      {Key? key,
      this.dashWidth = 9,
      this.dashSpace = 5,
      this.strokeWidth = 1,
      this.axis = Axis.horizontal,
      this.color = Colors.grey})
      : super(key: key);

  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;
  final Axis axis;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedLinePainter(
          dashSpace: dashSpace,
          dashWidth: dashWidth,
          strokeWidth: strokeWidth,
          axis: axis,
          color: color),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final double dashWidth;
  final double dashSpace;
  final double strokeWidth;
  final Axis axis;
  final Color color;
  DashedLinePainter({
    required this.dashWidth,
    required this.dashSpace,
    required this.strokeWidth,
    required this.axis,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // double dashWidth = 9, dashSpace = 5, startX = 0;
    double start = 0;
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;
    if (axis == Axis.horizontal) {
      while (start < size.width) {
        canvas.drawLine(Offset(start, 0), Offset(start + dashWidth, 0), paint);
        start += dashWidth + dashSpace;
      }
    } else {
      while (start < size.height) {
        canvas.drawLine(Offset(0, start), Offset(0, start + dashWidth), paint);
        start += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
