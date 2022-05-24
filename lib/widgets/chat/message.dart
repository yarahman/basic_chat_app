import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../chat/message_bubble.dart';

class Message extends StatelessWidget {
   Message({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createAt', descending: true)
          .snapshots(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final document = snapshot.data;
        return ListView.builder(
          reverse: true,
          itemCount: document == null ? 0 : document.docs.length,
          itemBuilder: ((context, index) {
            return MessageBubble(
                document!.docs[index]['text'], document.docs[index]['userId'] == user,key: ValueKey(document.docs[index].id),);
          }),
        );
      }),
    );
  }
}
