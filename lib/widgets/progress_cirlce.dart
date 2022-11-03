import 'dart:math';

import 'package:flutter/material.dart';

class ProgressCircle extends StatefulWidget {
  final int percentProgress;
  final Function onActionTap;
  const ProgressCircle(
      {Key? key, required this.percentProgress, required this.onActionTap})
      : super(key: key);

  @override
  State<ProgressCircle> createState() => _ProgressCircleState();
}

class _ProgressCircleState extends State<ProgressCircle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onActionTap(),
      child: Center(
        child: CustomPaint(
          foregroundPainter: CircleProgress(widget.percentProgress),
          child: Container(
            padding: const EdgeInsets.all(6),
            child: const Center(
              child: Icon(
                Icons.cancel,
                size: 22,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CircleProgress extends CustomPainter {
  int currentProgress = 0;
  CircleProgress(this.currentProgress);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 2.4
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = 15;
    canvas.drawCircle(center, radius, paint);

    // draw paint animation
    Paint paintAnimation = Paint()
      ..strokeWidth = 2.4
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double angle = 2 * pi * (currentProgress / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), pi / 2,
        angle, false, paintAnimation);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
