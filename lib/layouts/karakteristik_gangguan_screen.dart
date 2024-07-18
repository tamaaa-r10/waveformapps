import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../layouts/home_screen.dart';
import '../layouts/partials/gangguan_hewan_screen.dart';
import '../layouts/partials/gangguan_kabel_screen.dart';
import '../layouts/partials/gangguan_petir_screen.dart';
import '../layouts/partials/gangguan_pohon_screen.dart';

import '../colors/color.dart';
import '../components/seconds_background.dart';

class KarakteristikGangguan extends StatefulWidget {
  const KarakteristikGangguan({super.key});

  @override
  State<KarakteristikGangguan> createState() => _KarakteristikGangguanState();
}

class _KarakteristikGangguanState extends State<KarakteristikGangguan> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          children: [
            SecondBackground(),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.fromLTRB(20, 50, 0, 0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => HomeScreen(),
                          // Ganti dengan halaman utama yang sesuai
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            var begin = Offset(-1.0, 0.0);
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
                        ));
                      },
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
                      iconSize: 22.0,
                      style: IconButton.styleFrom(
                        shape: CircleBorder(),
                        shadowColor: Colors.black38,
                        backgroundColor: Colors.white70,
                        elevation: 5.0,
                      ),
                      padding: EdgeInsets.all(10.0),
                    ),
                  ),
                  TitleandImageKarakteristikGangguan(),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: ButtonGangguan(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleandImageKarakteristikGangguan extends StatelessWidget {
  const TitleandImageKarakteristikGangguan({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.fromLTRB(0, 20.0, 0, 10.0),
            width: screenWidth * 0.50,
            height: 150.0,
            child: Center(
              child: SvgPicture.asset(
                'assets/images/wave_sine.svg',
                width: screenWidth * 0.12,
                height: screenHeight * 0.12,
              ),
            )),
        Container(
          margin: EdgeInsets.fromLTRB(0, 20.0, 0, 10.0),
          padding: EdgeInsets.all(5.0),
          width: screenWidth * 0.50,
          alignment: Alignment.centerLeft,
          height: 150.0,
          child: Center(
            child: Transform.translate(
              offset: Offset(-20.0, -6.0),
              child: Wrap(
                children: [
                  Text(
                    'Karakteristik Gelombang Gangguan',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Jost',
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ButtonGangguan extends StatelessWidget {
  const ButtonGangguan({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(15, 85, 15, 15),
          child: Center(
            child: Container(
              width: 275,
              height: 50,
              padding: EdgeInsets.all(0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => GangguanPetir(),
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
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    backgroundColor: CustomColors.Ziggurat),
                child: Text(
                  'Gangguan Petir',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Jost',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0,
                      color: Colors.black),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: Center(
            child: Container(
              width: 275,
              height: 50,
              padding: EdgeInsets.all(0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => GangguanPohon(),
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
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    backgroundColor: CustomColors.Tropical_Blue),
                child: Text(
                  'Gangguan Pohon',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Jost',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0,
                      color: Colors.black),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: Center(
            child: Container(
              width: 275,
              height: 50,
              padding: EdgeInsets.all(0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => GangguanHewan(),
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
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    backgroundColor: CustomColors.Ziggurat),
                child: Text(
                  'Gangguan Hewan',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Jost',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0,
                      color: Colors.black),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: Center(
            child: Container(
              width: 275,
              height: 50,
              padding: EdgeInsets.all(0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => GangguanKabel(),
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
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    backgroundColor: CustomColors.Tropical_Blue),
                child: Text(
                  'Gangguan Konduktor Putus',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Jost',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
