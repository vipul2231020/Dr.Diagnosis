import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../common_files/colors.dart';


class predictor extends StatefulWidget {
  const predictor({super.key});

  @override
  State<predictor> createState() => _predictorState();
}

class _predictorState extends State<predictor> {
  final TextEditingController _controller = TextEditingController();
  String _response = '';
  String description = '';
  List<String> diet = [];
  List<String> precautions = [];
  List<String> medications = [];
  String disease = '';
  List<String> workout = [];

  Future<void> sendMessageToServer(String inputText) async {
    final Map<String, dynamic> jsonData = {'symptoms': inputText};
    final url = Uri.parse('https://symptoms-predict.onrender.com/predict');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(response.body);

        // Parse stringified lists
        List<String> parseList(String raw) {
          return (jsonDecode(raw.replaceAll("'", '"')) as List).cast<String>();
        }

        setState(() {
          _response = '✅ Success';
          description = decoded['description'] ?? '';
          disease = decoded['predicted_disease'] ?? '';
          diet = parseList(decoded['diet'][0]);
          medications = parseList(decoded['medications'][0]);
          precautions = List<String>.from(decoded['precautions']);
          workout = List<String>.from(decoded['workout']);
        });
      } else {
        setState(() {
          _response = "❌ Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _response = "⚠️ Network error: $e";
      });
    }
  }

  Widget buildResponsiveCard(String title, List<String> items,
      double screenWidth) {
    return Card(
      color: AppTheme.lightBlue,
      elevation: 10,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(screenWidth > 600 ? 20 : 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: screenWidth > 600 ? 20 : 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8,width: screenWidth * .9,),
            ...items.map((item) =>
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Text("• $item",
                      style: TextStyle(fontSize: screenWidth > 600 ? 16 : 14)),
                )),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final isWideScreen = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text("Predict Your Disease Here",style: TextStyle(color: Colors.white),),
        backgroundColor: AppTheme.dark,),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isWideScreen ? screenWidth * 0.15 : 16,
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Enter The Symtoms You Are Feeling ??",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final input = _controller.text;
                  if (input.isNotEmpty) {
                    sendMessageToServer(input);
                  }
                },
                child: const Text("Predict Disease"),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _response,
              style: const TextStyle(fontSize: 14, color: Colors.blue),
            ),
            if (disease.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text("Predicted Disease: $disease",
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleLarge),
                  const SizedBox(height: 10),
                  buildResponsiveCard(
                      "Description", [description], screenWidth),
                  buildResponsiveCard("Diet", diet, screenWidth),
                  buildResponsiveCard("Medications", medications, screenWidth),
                  buildResponsiveCard("Precautions", precautions, screenWidth),
                  buildResponsiveCard("Workout", workout, screenWidth),
                ],
              ),
          ],
        ),
      ),

    );
  }
}

