import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../common_files/colors.dart';

class chatbot extends StatefulWidget {
  const chatbot({super.key});

  @override
  State<chatbot> createState() => _chatbotState();
}


class _chatbotState extends State<chatbot> {
  // Add this inside your StatefulWidget
  bool _isProcessing = false;

  final Color primaryColor = AppTheme.dark; // Dark Blue
  final Color lightBlue = AppTheme.lightBlue;
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  String output = "";
  int code = 101;

  // void _sendMessage() {
  //   String text = _controller.text.trim();
  //   if (text.isEmpty) return;
  //   //_getWitReply(text);
  //   setState(() {
  //     _messages.add({'sender': 'user', 'text': text});
  //     _messages.add({'sender': 'bot', 'text': _getBotResponse(output)});
  //     _controller.clear();
  //   });
  // }

  // String _getBotResponse(String message) {
  //   return message;
  // }


  Future<void> _getWitReply(String message) async {
    final url = Uri.parse('https://api-assist.onrender.com/chat');
    final Map<String, dynamic> jsonData = {'message': message, 'history': []};

    // Add user message immediately
    setState(() {
      _messages.add({'sender': 'user', 'text': message});
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['chatbot_output'].isNotEmpty) {
          final botReply = data['chatbot_output'][0][1];

          // Add bot reply to messages
          setState(() {
            _messages.add({'sender': 'bot', 'text': botReply});
          });
        } else {
          setState(() {
            _messages.add({'sender': 'bot', 'text': 'Sorry, I didn\'t understand that.'});
          });
        }
      } else {
        setState(() {
          _messages.add({
            'sender': 'bot',
            'text': 'Something went wrong. Please try again later.'
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({
          'sender': 'bot',
          'text': 'Server error: ${e.toString()}'
        });
      });
    }

    _controller.clear(); // Clear input after response
  }


  Widget _buildMessage(Map<String, String> message) {
    bool isUser = message['sender'] == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? Colors.blueAccent : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(isUser ? 18 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Text(
          message['text'] ?? '',
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          "Your Personal AI Doctor 🩺", style: TextStyle(color: Colors.white),),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 10),
              itemCount: _messages.length,
              itemBuilder: (context, index) =>
                  _buildMessage(_messages[index]),
            ),
          ),
          Divider(height: 1),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: InputBorder.none,
                    ),
                    //onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.deepPurpleAccent),
                  onPressed: () {
                    final input = _controller.text;
                    if (input.isNotEmpty) {
                      _getWitReply(input);
                    }
                    //_sendMessage();

                  },
                )
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFFF2F2F7),
    );
  }

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       iconTheme: IconThemeData(
  //         color: Colors.white, //change your color here
  //       ),
  //       title: Text(
  //         "Your Personal AI Doctor 🩺", style: TextStyle(color: Colors.white),),
  //       backgroundColor: primaryColor,
  //       centerTitle: true,
  //     ),
  //     body: Column(
  //       children: [
  //         Expanded(
  //           child: ListView.builder(
  //             padding: EdgeInsets.symmetric(vertical: 10),
  //             itemCount: _messages.length,
  //             itemBuilder: (context, index) =>
  //                 _buildMessage(_messages[index]),
  //           ),
  //         ),
  //         Divider(height: 1),
  //         Container(
  //           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  //           color: Colors.white,
  //           child: Row(
  //             children: [
  //               Expanded(
  //                 child: TextField(
  //                   controller: _controller,
  //                   decoration: InputDecoration(
  //                     hintText: "Type your message...",
  //                     border: InputBorder.none,
  //                   ),
  //                   onSubmitted: (_) => _sendMessage(),
  //                 ),
  //               ),
  //               IconButton(
  //                 icon: Icon(Icons.send, color: Colors.deepPurpleAccent),
  //                 onPressed: () {
  //                   final input = _controller.text;
  //                   if (input.isNotEmpty) {
  //                     _getWitReply(input);
  //                   }
  //                   //_sendMessage();
  //
  //                 },
  //               )
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //     backgroundColor: Color(0xFFF2F2F7),
  //   );
  // }
}