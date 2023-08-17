import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../themes.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final TextEditingController messageController = TextEditingController();
  String message = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();

    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    FirebaseFirestore.instance.collection('chat').add({
      'text': message,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData['username'],
      'userImage':userData['user_image'],
    });
    messageController.clear();
    setState(() {
      message='';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            style: const TextStyle(color: blueBlackColor),
            controller: messageController,
            onChanged: (val) {
              message = val;
            },
            cursorColor: blueBlackColor,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: blueBlackColor,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              suffixIcon: IconButton(
                  color:blueBlackColor ,
                  disabledColor:Colors.grey ,
                  onPressed: () =>
                      message.trim().isEmpty ? null : _sendMessage(),
                  icon: const Icon(
                    Icons.send,
                  )),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: 'send a message..',
            ),
          )),
        ],
      ),
    );
  }
}
