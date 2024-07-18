import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'dart:io';

class SubmitFormPage extends StatefulWidget {
  @override
  _SubmitFormPageState createState() => _SubmitFormPageState();
}

class _SubmitFormPageState extends State<SubmitFormPage> {
  final _formKey = GlobalKey<FormState>();
  String place = '';
  String time = '';
  File? selectedFile;

  void _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    }
  }

  void _selectTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        time = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      });
    }
  }

  Future<void> submitForm() async {
    if (_formKey.currentState!.validate() && selectedFile != null) {
      _formKey.currentState!.save();

      var request = http.MultipartRequest('POST', Uri.parse('http://192.168.1.14:5000/submit_data'));
      request.fields['place'] = place;
      request.fields['time'] = time;
      request.files.add(await http.MultipartFile.fromPath('file', selectedFile!.path));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var responseData = jsonDecode(responseBody);
        if (responseData['message'] == 'Data Berhasil Diproses') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(result: responseData['data']),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${responseData['error']}')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: Failed to process data')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please complete the form and select a file')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Place'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the place';
                  }
                  return null;
                },
                onSaved: (value) {
                  place = value!;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _selectTime,
                child: Text('Select Time'),
              ),
              SizedBox(height: 16),
              Text(time),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _selectFile,
                child: Text('Upload CSV File'),
              ),
              SizedBox(height: 16),
              Text(selectedFile != null ? selectedFile!.path.split('/').last : 'No file selected'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final Map<String, dynamic> result;

  ResultPage({required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Place: ${result['place']}'),
            Text('Time: ${result['time']}'),
            Text('Disturbance: ${result['disturbance']}'),
            Text('Accuracy: ${result['accuracy']}%'),
          ],
        ),
      ),
    );
  }
}
