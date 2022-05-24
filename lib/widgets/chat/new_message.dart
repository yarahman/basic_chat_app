import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredValue = '';
  final _entervalueController = TextEditingController();

  void sentMessage() {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredValue,
      'createAt': Timestamp.now(),
      'userId' : user!.uid,
    });
    _entervalueController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              label: Text('write a message ...'),
            ),
            onChanged: (value) {
              setState(() {
                _enteredValue = value;
              });
            },
            controller: _entervalueController,
          ),
        ),
        IconButton(
          onPressed: _enteredValue.trim().isEmpty ? null : sentMessage,
          icon: const Icon(Icons.send),
        ),
      ],
    );
  }
}
