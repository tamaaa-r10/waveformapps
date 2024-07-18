import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../colors/color.dart';
import '../components/seconds_background.dart';
import '../layouts/home_screen.dart';
// import '../layouts/partials/result_deteksi_trouble_screen.dart';

class DeteksiTrouble extends StatefulWidget {
  const DeteksiTrouble({super.key});

  @override
  State<DeteksiTrouble> createState() => _DeteksiTroubleState();
}

class _DeteksiTroubleState extends State<DeteksiTrouble> {
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
                          Navigator.of(context)
                              .pushReplacement(PageRouteBuilder(
                            pageBuilder: (_, __, ___) => HomeScreen(),
                            // Ganti dengan halaman utama yang sesuai
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
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
                      )),
                  TitleandImageDeteksiTrouble(),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TroubleForm(),
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

class TitleandImageDeteksiTrouble extends StatelessWidget {
  const TitleandImageDeteksiTrouble({super.key});

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
                'assets/images/image_search.svg',
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
                    'Deteksi Trouble',
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

class TroubleForm extends StatefulWidget {
  @override
  _TroubleFormState createState() => _TroubleFormState();
}

class _TroubleFormState extends State<TroubleForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _tempatController = TextEditingController();
  File? _csvFile;
  TimeOfDay? _selectedTime;
  String _selectedTimeString = 'Pilih Waktu';

  void _clearForm() {
    _formKey.currentState?.reset();
    _tempatController.clear();
    _selectedTimeString = 'Pilih Waktu';
    setState(() {
      _csvFile = null;
      _selectedTime = null;
    });
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null && result.files.single.extension == 'csv') {
      setState(() {
        _csvFile = File(result.files.single.path!);
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Silahkan pilih file CSV')));
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        final now = DateTime.now();
        final formattedTime = DateFormat('HH:mm').format(
          DateTime(now.year, now.month, now.day, _selectedTime!.hour,
              _selectedTime!.minute),
        );
        _selectedTimeString = formattedTime;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();

      String _place = _tempatController.text;
      String _time = _selectedTimeString ?? 'No time selected';

      showLoading();

      String url = 'http://192.168.255.195:5000/submit_data';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['place'] = _place;
      request.fields['time'] = _time;

      if (_csvFile != null) {
        request.files
            .add(await http.MultipartFile.fromPath('file', _csvFile!.path));
      }

      try {
        final response = await request.send().timeout(Duration(minutes: 30));
        final responseBody = await response.stream
            .bytesToString()
            .timeout(Duration(minutes: 30));

        Navigator.of(context, rootNavigator: true).pop();

        if (response.statusCode == 200) {
          final responseData = json.decode(responseBody);
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) =>
                  ResultDeteksiTrouble(responseData: responseData['data']),
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
        } else {
          print('Response Body: $responseBody'); // Log full response body
          final errorData = json.decode(responseBody);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${errorData['error']}')),
          );
        }
      } catch (e) {
        print('Exception: $e'); // Log the exception
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void showLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white70.withOpacity(0.6),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/animation/loader_animation.json',
                  width: 100.0, fit: BoxFit.fitWidth),
              SizedBox(
                height: 20,
              ),
              Text(
                'Loading',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Jost',
                    color: Colors.black87,
                    decoration: TextDecoration.none),
              )
            ],
          )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tempat Kejadian : ',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                fontFamily: 'Jost'),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _tempatController,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0)),
                hintText: 'Tempat Kejadian',
                border: OutlineInputBorder()),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan Tempat Kejadian';
              }
              return null;
            },
            style: TextStyle(fontFamily: 'Jost', fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 16.0),
          Text(
            'Waktu Kejadian : ',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                fontFamily: 'Jost'),
          ),
          SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {
              _selectTime(context);
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Warna border
                  side: BorderSide(color: Colors.black87.withOpacity(0.7)),
                ),
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                _selectedTimeString,
                style: TextStyle(fontFamily: 'Jost', color: Colors.black),
              ),
            ),
          ),
          SizedBox(height: 25.0),
          GestureDetector(
            onTap: _pickFile,
            child: DottedBorder(
              color: Colors.black,
              strokeWidth: 3,
              dashPattern: [8, 3],
              borderType: BorderType.RRect,
              radius: Radius.circular(10.0),
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 50, 10, 30),
                width: screenWidth,
                height: 200,
                alignment: Alignment.center,
                child: _csvFile == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/unduhan.svg',
                            width: 40,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Dokumen Gangguan (.csv)',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Jost'),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/files_icon.svg',
                            width: 60,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${_csvFile!.path.split('/').last}',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Jost'),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
              ),
            ),
          ),
          SizedBox(height: 46.0),
          Center(
            child: ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: CustomColors.Ziggurat),
              child: Padding(
                padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
                child: Text(
                  'Submit',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Jost',
                      letterSpacing: 0,
                      color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResultDeteksiTrouble extends StatelessWidget {
  final Map<String, dynamic> responseData;

  ResultDeteksiTrouble({required this.responseData});

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
                          Navigator.pushAndRemoveUntil(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => DeteksiTrouble(),
                                // Ganti dengan halaman utama yang sesuai
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
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
                              ),
                              (route) => false);
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
                      )),
                  TitleandImageDeteksiTrouble(),
                  Container(
                    width: screenWidth,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Wrap(
                              children: [
                                Text(
                                  'Hasil Klasifikasi Gangguan',
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontFamily: 'Jost',
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Tempat Terjadi Gangguan: ',
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Jost',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${responseData['place']}',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Jost',
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Waktu Gangguan: ',
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Jost',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${responseData['time']}',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Jost',
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Gangguan Disebabkan Oleh : ',
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Jost',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${responseData['disturbance']}',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Jost',
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Accuracy: ',
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Jost',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${responseData['accuracy'].toStringAsFixed(2)}%',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Jost',
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
