import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/chat/new_message.dart';


import '../widgets/chat/message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chat'),
        actions: [
          IconButton(
              onPressed: (() {
                FirebaseAuth.instance.signOut();
              }),
              icon: const Icon(Icons.logout))
        ],
      ),
      body:Container(
        child: Column(children: [
          Expanded(child: Message()),
          NewMessage(),
        ],),
      ),
    );
  }
}
