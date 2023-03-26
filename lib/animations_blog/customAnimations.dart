import 'dart:math';

import 'package:flutter/material.dart';

class CustomPaintAnimation extends StatefulWidget {
  @override
  _CustomPaintAnimationState createState() => _CustomPaintAnimationState();
}

class _CustomPaintAnimationState extends State<CustomPaintAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                return CustomPaint(
                  painter: CirclePainter(
                    controller,
                  ),
                  child: Container(),
                );
              })),
    );
  }
}

class CirclePainter extends CustomPainter {
  final Animation<double> animation;

  CirclePainter(
    this.animation,
  );

  @override
  void paint(Canvas canvas, Size size) {
    double percentage = animation.value * 100;
    double radius = 100.0;
    final c = Offset(size.width / 2, size.height / 2);
    drawCircle(canvas, c, radius);
    drawArc(canvas, c, radius, percentage);
  }

  void drawCircle(Canvas canvas, Offset c, double radius) {
    Paint paint = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = Colors.orange;
    canvas.drawCircle(c, radius, paint);
  }

  void drawArc(Canvas canvas, Offset center, double radius, double percentage) {
    Rect rect =
        Rect.fromCenter(center: center, width: 2 * radius, height: 2 * radius);
    Paint paint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white,
          Colors.yellow,
          Colors.orange,
          Colors.red.shade400
        ],
      ).createShader(rect)
      ..color = Colors.orangeAccent
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    const startAngle = -90 * pi / 180;
    final sweepAngle = (360 * percentage * 0.01) * pi / 180;
    canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
