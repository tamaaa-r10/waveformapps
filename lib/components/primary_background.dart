// import 'dart:js';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../colors/color.dart';

class PrimaryBackground extends StatelessWidget {
  const PrimaryBackground({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeigth = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeigth,
      color: CustomColors.Parchment,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            width: screenWidth,
            height: screenHeigth,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Transform.rotate(
                    angle: math.pi,
                    child: CustomPaint(
                      size: Size(MediaQuery.of(context).size.width, 200), // Atur ukuran sesuai kebutuhan Anda
                      painter: HalfCirclePainter(
                          orientation: HalfCircleOrientation.top),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 70,
                      color: CustomColors.Havelock_Blue, // Warna kotak panjang
                    ),
                  ),
                  Positioned(
                    child: CustomPaint(
                      size: Size(MediaQuery.of(context).size.width,
                          200), // Atur ukuran sesuai kebutuhan Anda
                      painter: HalfCirclePainter(
                          orientation: HalfCircleOrientation.top),
                    ),
                  ),
                ]),
          ),
          Positioned.fill(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
                child: SizedBox()
            ),
          )
        ],
      ),
    );
  }
}

enum HalfCircleOrientation { top, bottom }

class HalfCirclePainter extends CustomPainter {
  final HalfCircleOrientation orientation;

  HalfCirclePainter({required this.orientation});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = CustomColors.Denim
      ..style = PaintingStyle.fill;

    double radius = size.height * 1.4;
    Offset center;

    if (orientation == HalfCircleOrientation.top) {
      center = Offset(size.width / 2, size.height / 0.53);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        math.pi,
        math.pi,
        true,
        paint,
      );
    } else {
      center = Offset(size.width / 2, 0);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi,
        math.pi,
        true,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
