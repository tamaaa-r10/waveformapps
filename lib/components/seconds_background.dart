import 'dart:ui';

import 'package:flutter/material.dart';

import '../colors/color.dart';

class SecondBackground extends StatelessWidget {
  const SecondBackground({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight,
      child: Stack(
          children: [
            Positioned(
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          CustomColors.Parchment,
                          CustomColors.Parchment,
                          CustomColors.Tropical_Blue,
                          CustomColors.Tropical_Blue,
                          CustomColors.Tropical_Blue,
                        ],
                        stops: [0.0, 0.2, 0.5, 0.9, 1.0]
                    )
                ),
              ),
            ),Positioned(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
                  child: SizedBox(),
                )
            ),
          ]
      ),
    );
  }
}
