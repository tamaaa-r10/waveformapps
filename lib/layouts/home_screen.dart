import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../components/primary_background.dart';
import '../layouts/cara_penggunaan_screen.dart';
import '../layouts/deteksi_trouble_screen.dart';
import '../layouts/karakteristik_gangguan_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PrimaryBackground(),
          SingleChildScrollView(
            child: Column(
              children: [
                GreetingText(),
                RowButtonMenuTop(),
                RowButtonMenuBottom()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GreetingText extends StatelessWidget {
  const GreetingText({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Row(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 100.0, 0, 30.0),
          width: screenWidth * 0.50,
          height: 150.0,
          child: Image.asset(
            'assets/images/man_pose.png',
            width: 200.0,
            height: 700.0,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 100.0, 0, 30.0),
          padding: EdgeInsets.all(15.0),
          width: screenWidth * 0.50,
          height: 150.0,
          child: Center(
            child: Wrap(
              children: [
                Text(
                  'SUTT Aman, Listrik Lancar, Laporkan Gangguan',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Jost'),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class RowButtonMenuTop extends StatefulWidget {
  const RowButtonMenuTop({super.key});

  @override
  State<RowButtonMenuTop> createState() => _RowButtonMenuTopState();
}

class _RowButtonMenuTopState extends State<RowButtonMenuTop> {
  bool isPressedDeteksiButton = false;
  bool isPressedKarakteristikButton = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Row(
      children: [
        Center(
          child: Container(
            width: screenWidth * 0.50,
            height: screenHeight * 0.25,
            margin: EdgeInsets.only(top: 70),
            padding: EdgeInsets.all(5),
            child: Center(
              child: GestureDetector(
                onTapDown: (_) {
                  setState(
                    () {
                      isPressedDeteksiButton = true;
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => DeteksiTrouble(),
                          // Ganti dengan halaman utama yang sesuai
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin = Offset(1.0, 0.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                          transitionDuration: Duration(milliseconds: 500),
                        ),
                      );
                    },
                  );
                },
                onTapUp: (_) {
                  setState(() {
                    isPressedDeteksiButton = false;
                  });
                },
                onTapCancel: () {
                  setState(() {
                    isPressedDeteksiButton = false;
                  });
                },
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 30),
                      width: 110.0,
                      height: 110.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white10.withOpacity(0.14),
                              Colors.white10.withOpacity(0.14),
                              Colors.white70.withOpacity(0.35),
                              Colors.white70.withOpacity(0.35),
                              Colors.white10.withOpacity(0.14),
                              Colors.white10.withOpacity(0.14),
                            ],
                            stops: [
                              0.1,
                              0.3,
                              0.4,
                              0.6,
                              0.7,
                              0.9
                            ]),
                        borderRadius: BorderRadius.circular(25.0),
                        // Sudut border dengan radius
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.1),
                            // Warna bayangan putih dengan opacity rendah
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 1), // Offset bayangan dari kotak
                          ),
                        ],
                        border: isPressedDeteksiButton
                            ? Border.all(color: Colors.white70)
                            : Border.all(color: Colors.white24),
                      ),
                      child: Center(
                          child: SvgPicture.asset(
                        'assets/images/image_search.svg',
                        width: 55.0,
                        height: 55.0,
                      )),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Deteksi Trouble',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Jost'),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            width: screenWidth * 0.50,
            height: screenHeight * 0.25,
            margin: EdgeInsets.only(top: 70),
            padding: EdgeInsets.all(5),
            child: Center(
              child: GestureDetector(
                onTapDown: (_) {
                  setState(() {
                    isPressedKarakteristikButton = true;
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => KarakteristikGangguan(),
                        // Ganti dengan halaman utama yang sesuai
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var begin = Offset(1.0, 0.0);
                          var end = Offset.zero;
                          var curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                        transitionDuration: Duration(milliseconds: 500),
                      ),
                    );
                  });
                },
                onTapUp: (_) {
                  setState(() {
                    isPressedKarakteristikButton = false;
                  });
                },
                onTapCancel: () {
                  setState(() {
                    isPressedKarakteristikButton = false;
                  });
                },
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 30),
                      width: 110.0,
                      height: 110.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white10.withOpacity(0.14),
                              Colors.white10.withOpacity(0.14),
                              Colors.white70.withOpacity(0.35),
                              Colors.white70.withOpacity(0.35),
                              Colors.white10.withOpacity(0.14),
                              Colors.white10.withOpacity(0.14),
                            ],
                            stops: [
                              0.1,
                              0.3,
                              0.4,
                              0.6,
                              0.7,
                              0.9
                            ]),
                        borderRadius: BorderRadius.circular(25.0),
                        // Sudut border dengan radius
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.1),
                            // Warna bayangan putih dengan opacity rendah
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 1), // Offset bayangan dari kotak
                          ),
                        ],
                        border: isPressedKarakteristikButton
                            ? Border.all(color: Colors.white70)
                            : Border.all(color: Colors.white24),
                      ),
                      child: Center(
                          child: SvgPicture.asset(
                        'assets/images/wave_sine.svg',
                        width: 55.0,
                        height: 55.0,
                      )),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Wrap(
                      children: [
                        Text(
                          'Karakteristik Gangguan',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Jost'),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RowButtonMenuBottom extends StatefulWidget {
  const RowButtonMenuBottom({super.key});

  @override
  State<RowButtonMenuBottom> createState() => _RowButtonMenuBottomState();
}

class _RowButtonMenuBottomState extends State<RowButtonMenuBottom> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Container(
        width: screenWidth * 0.50,
        height: screenHeight * 0.25,
        padding: EdgeInsets.all(5),
        child: Center(
          child: GestureDetector(
            onTapDown: (_) {
              setState(() {
                isPressed = true;
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => CaraPenggunaanAplikasi(),
                    // Ganti dengan halaman utama yang sesuai
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var begin = Offset(1.0, 0.0);
                      var end = Offset.zero;
                      var curve = Curves.ease;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 500),
                  ),
                );
              });
            },
            onTapUp: (_) {
              setState(() {
                isPressed = false;
              });
            },
            onTapCancel: () {
              setState(() {
                isPressed = false;
              });
            },
            child: Column(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 30),
                  width: 110.0,
                  height: 110.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white10.withOpacity(0.14),
                          Colors.white10.withOpacity(0.14),
                          Colors.white70.withOpacity(0.35),
                          Colors.white70.withOpacity(0.35),
                          Colors.white10.withOpacity(0.14),
                          Colors.white10.withOpacity(0.14),
                        ],
                        stops: [
                          0.1,
                          0.3,
                          0.4,
                          0.6,
                          0.7,
                          0.9
                        ]),
                    borderRadius: BorderRadius.circular(25.0),
                    // Sudut border dengan radius
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        // Warna bayangan putih dengan opacity rendah
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 1), // Offset bayangan dari kotak
                      ),
                    ],
                    border: isPressed
                        ? Border.all(color: Colors.white70)
                        : Border.all(color: Colors.white24),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/tower.png',
                      width: 75.0,
                      height: 75.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Tata Cara \nPenggunaan Aplikasi',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Jost'),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
