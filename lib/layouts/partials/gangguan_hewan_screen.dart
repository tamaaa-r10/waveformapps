import 'package:flutter/material.dart';
import '../../components/primary_background.dart';
import 'package:flutter_svg/svg.dart';
import '../../components/seconds_background.dart';
import '../../layouts/karakteristik_gangguan_screen.dart';

import '../../colors/color.dart';
import '../../components/back_button.dart';

class GangguanHewan extends StatelessWidget {
  const GangguanHewan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                          pageBuilder: (_, __, ___) => KarakteristikGangguan(),
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
                  TitleandImageKarakteristikGelombang(),
                  TextGangguanHewan(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Text('Contoh Gangguan Hewan',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Jost')),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 50),
                      child: Image.asset('assets/images/hewan.png'),
                    ),
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}

class TitleandImageKarakteristikGelombang extends StatelessWidget {
  const TitleandImageKarakteristikGelombang({super.key});

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
            width: screenWidth * 0.40,
            height: 150.0,
            child: Center(
              child: SvgPicture.asset(
                'assets/images/wave_sine.svg',
                width: screenWidth * 0.10,
                height: screenHeight * 0.10,
              ),
            )),
        Container(
          margin: EdgeInsets.fromLTRB(0, 20.0, 0, 10.0),
          padding: EdgeInsets.all(5.0),
          width: screenWidth * 0.60,
          alignment: Alignment.centerLeft,
          height: 150.0,
          child: Center(
            child: Transform.translate(
              offset: Offset(-20.0, -6.0),
              child: Wrap(
                children: [
                  Text(
                    'Gelombang Gangguan Hewan',
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

class TextGangguanHewan extends StatelessWidget {
  const TextGangguanHewan({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Text(
            'Gelombang Gangguan Hewan',
            style: TextStyle(
                fontSize: 24, fontFamily: 'Jost', fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            constraints: BoxConstraints(maxWidth: 400),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Wrap(
              children: [
                TextDummyGangguan(text: """
                  Ketika hewan mengenai peralatan listrik, hal tersebut mengakibatkan bentuk gelombang yang berbeda. Gangguan ini sering kali mengakibatkan korsleting yang terputus-putus atau berualang-ulang, sehingga menyebabkan fluktuasi gelombang arus dan tegangan. Bentuk gelombang tersebut menunjukkan lonjakan atau penurunan level arus dan tegangan secara tiba-tiba, bersamaan dengan pola yang tidak beraturan dan mengindikasi pergerakan hewan. 
                """)
              ],
            ),
          )
        ],
      ),
    );
  }
}


class TextDummyGangguan extends StatelessWidget {
  final String text;

  TextDummyGangguan({required this.text});

  @override
  Widget build(BuildContext context) {
    List<InlineSpan> textSpan = text.split('\n\n').map((paragraph) {
      return TextSpan(
        text: '\t$paragraph\n\n',
        style: TextStyle(fontSize: 16, height: 1.5),
      );
    }).toList();
    return Container(
        child: RichText(
          text: TextSpan(
            children: textSpan,
            style: TextStyle(color: Colors.black),
          ),
          textAlign: TextAlign.justify,
        ));
  }
}