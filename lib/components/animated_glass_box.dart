import 'package:flutter/material.dart';

class AnimatedGlassBox extends StatefulWidget {
  @override
  _AnimatedGlassBoxState createState() => _AnimatedGlassBoxState();
}

class _AnimatedGlassBoxState extends State<AnimatedGlassBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 1.0, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            width: 200.0,
            height: 200.0,
            decoration: BoxDecoration(
              color: Colors.white70.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(_animation.value * 0.5),
                  blurRadius: 20.0,
                  spreadRadius: 5.0,
                ),
              ],
            ),
            child: Center(
              child: Image.asset('assets/images/pln_logo.png', width: 100.0, height: 500.0,),
            ),
          );
        },
      ),
    );
  }
}
