import 'package:flutter/material.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/img/image (2).png"),
              radius: 20,
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Khaled Mohamed",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  "Active now",
                  style: TextStyle(color: Colors.green, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.phone, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.videocam, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                Center(
                  child: Text(
                    "Today",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                SizedBox(height: 12),
                UserMessageBubble(
                  message: "Hello! Khaled",
                  time: "09:25 AM",
                ),
                SupportMessageBubble(
                  message: "Hello! Omar How are you?",
                  time: "09:25 AM",
                ),
                UserMessageBubble(
                  message: "You did your job well!",
                  time: "09:25 AM",
                ),
                SupportMessageBubble(
                  message: "Have a great working week!!\nHope you like it",
                  time: "09:25 AM",
                ),
                VoiceMessageBubble(
                  duration: "00:16",
                  time: "09:25 AM",
                ),
              ],
            ),
          ),
          ChatInputField(),
        ],
      ),
    );
  }
}

class UserMessageBubble extends StatelessWidget {
  final String message;
  final String time;

  const UserMessageBubble({
    Key? key,
    required this.message,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          Text(
            time,
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class SupportMessageBubble extends StatelessWidget {
  final String message;
  final String time;

  const SupportMessageBubble({
    Key? key,
    required this.message,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          Text(
            time,
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class VoiceMessageBubble extends StatelessWidget {
  final String duration;
  final String time;

  const VoiceMessageBubble({
    Key? key,
    required this.duration,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.play_arrow, color: Colors.white),
                Expanded(
                  child: LinearProgressIndicator(
                    value: 0.7,
                    color: Colors.white,
                    backgroundColor: Colors.grey,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  duration,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class ChatInputField extends StatelessWidget {
  const ChatInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Write your message...",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Icon(Icons.attach_file, color: Colors.grey),
          SizedBox(width: 8),
          Icon(Icons.mic, color: Colors.grey),
        ],
      ),
    );
  }
}
