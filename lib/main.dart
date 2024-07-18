import 'package:flutter/material.dart';
import '../layouts/cara_penggunaan_screen.dart';
import '../layouts/deteksi_trouble_screen.dart';
import '../layouts/home_screen.dart';
import '../layouts/splash_screen.dart';
import '../trouble_deteksi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waveform App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
