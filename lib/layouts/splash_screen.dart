import 'package:flutter/material.dart';
import '../../components/primary_background.dart';
import 'home_screen.dart';
import '../../components/animated_glass_box.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // Contoh delay untuk simulasi inisialisasi atau pemrosesan awal
    Future.delayed(Duration(seconds: 5), () {
      // Navigasi ke halaman utama aplikasi dengan animasi slide out
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => HomeScreen(), // Ganti dengan halaman utama yang sesuai
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 500),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth,
      height: screenHeight,
      child: Stack(
        children: [
          PrimaryBackground(),
          AnimatedGlassBox()
        ],
      ),
    );
  }
}
