import 'package:flutter/material.dart';
import '../components/back_button.dart';
import '../components/seconds_background.dart';
import '../layouts/home_screen.dart';

import '../colors/color.dart';

class CaraPenggunaanAplikasi extends StatefulWidget {
  const CaraPenggunaanAplikasi({super.key});

  @override
  State<CaraPenggunaanAplikasi> createState() => _CaraPenggunaanAplikasiState();
}

class _CaraPenggunaanAplikasiState extends State<CaraPenggunaanAplikasi> {
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
                TitleandImageCaraPenggunaanAplikasi(),
                PenggunaanAplikasi(),
                RulesDeteksiTrouble(),
                RulesKarakteristikGangguan()
              ],
            ),
          )
        ],
      ),
    );
    ;
  }
}

class TitleandImageCaraPenggunaanAplikasi extends StatelessWidget {
  const TitleandImageCaraPenggunaanAplikasi({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.fromLTRB(0, 0.0, 0, 10.0),
            width: screenWidth * 0.50,
            height: 150.0,
            child: Center(
              child: Image.asset(
                'assets/images/tower.png',
                width: 115.0,
                height: 115.0,
              ),
            )),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0.0, 0, 10.0),
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
                    'Tata Cara Penggunaan Aplikasi',
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

class PenggunaanAplikasi extends StatelessWidget {
  final List<String> titleItems = [
    'Deteksi Trouble',
    'Karakteristik Gangguan',
    'Tata Cara Penggunaan Aplikasi',
  ];
  final List<String> subtitleItems = [
    'Digunakan untuk mengetahui gangguan disebabkan oleh apa',
    'Digunakan untuk mengetahui karakteristik secara umum dari setiap gangguan',
    'Digunakan untuk memberi petunjuk penggunaan aplikasi',
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      margin: EdgeInsets.only(top: 20),
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Text(
            'Cara Menggunakan Aplikasi',
            style: TextStyle(
                fontSize: 24, fontFamily: 'Jost', fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: screenWidth,
            margin: EdgeInsets.symmetric(horizontal: 25),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: CustomColors.Ziggurat,
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: <Widget>[
                Text(
                  'Pada halaman awal terdapat beberapa menu, diantaranya :',
                  style: TextStyle(fontSize: 20, fontFamily: 'Jost'),
                  textAlign: TextAlign.justify,
                ),
                for (int i = 0; i < titleItems.length; i++)
                  ListTile(
                    leading: Icon(
                      Icons.circle,
                      color: Colors.black,
                      size: 10,
                    ),
                    title: Text(
                      '${titleItems[i]}',
                      style: TextStyle(fontSize: 18, fontFamily: 'Jost', fontWeight: FontWeight.bold),
                      textAlign: TextAlign.justify,
                    ),
                    subtitle: Text('${subtitleItems[i]}', style: TextStyle(fontSize: 18, fontFamily: 'Jost'), textAlign: TextAlign.justify,),
                    contentPadding: EdgeInsets.zero,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RulesKarakteristikGangguan extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      margin: EdgeInsets.only(top: 50),
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'Karakteristik Gelombang Gangguan',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Jost',
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: screenWidth,
            margin: EdgeInsets.fromLTRB(25, 0, 25, 50),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: CustomColors.Ziggurat,
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: <Widget>[
                Text(
                  'Pada halaman ini menampilkan detail karakteristik gangguan dari setiap penyebab seperti, petir, pohon, hewan dan konduktor putus. ',
                  style: TextStyle(fontSize: 20, fontFamily: 'Jost'),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RulesDeteksiTrouble extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      margin: EdgeInsets.only(top: 40),
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Text(
            'Deteksi Trouble',
            style: TextStyle(
                fontSize: 24, fontFamily: 'Jost', fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
              width: screenWidth,
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  color: CustomColors.Ziggurat,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(maxHeight: 50, maxWidth: 50),
                    width: 45,
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: CustomColors.Tropical_Blue,
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      '1',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Jost',
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.68,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Wrap(
                      children: [
                        Text(
                          'Siapkan data terjadi gangguan dalam bentuk .CSV',
                          style: TextStyle(fontSize: 20, fontFamily: 'Jost'),
                          textAlign: TextAlign.justify,
                        )
                      ],
                    ),
                  )
                ],
              )),
          SizedBox(
            height: 20,
          ),
          Container(
            width: screenWidth,
            margin: EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
                color: CustomColors.Tropical_Blue,
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(maxHeight: 50, maxWidth: 50),
                  width: 45,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: CustomColors.Ziggurat,
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    '2',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: screenWidth * 0.68,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Wrap(
                    children: [
                      Text(
                        'Masukkan tempat terjadi gangguan, waktu, dan Data gangguan yang akan di proses',
                        style: TextStyle(fontSize: 20, fontFamily: 'Jost'),
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: screenWidth,
            margin: EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
                color: CustomColors.Ziggurat,
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(maxHeight: 50, maxWidth: 50),
                  width: 45,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: CustomColors.Tropical_Blue,
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    '3',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: screenWidth * 0.68,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Wrap(
                    children: [
                      Text(
                        'Tunggu dan akan ditampilkan hasil penyebab gangguan',
                        style: TextStyle(fontSize: 20, fontFamily: 'Jost'),
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextListWithIcons extends StatelessWidget {
  final List<String> items = [
    'Ini adalah teks pertama',
    'Ini adalah teks kedua',
    'Ini adalah teks ketiga',
    'Ini adalah teks keempat',
    'Ini adalah teks kelima',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              Icon(Icons.circle, size: 10.0, color: Colors.blue),
              SizedBox(width: 10.0),
              Expanded(child: Text(item)),
            ],
          ),
        );
      }).toList(),
    );
  }
}
