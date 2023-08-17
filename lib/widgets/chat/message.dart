import 'package:chat/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_style.dart';

class Message extends StatelessWidget {
  const Message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt',descending: true).snapshots(),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(
            color: blueBlackColor,
          );
        }
        final docs = snapShot.data!.docs;
final auth=FirebaseAuth.instance.currentUser;
        return ListView.builder(
            reverse: true,
            itemCount: docs.length,
            itemBuilder: (context, index) {
              return MessageStyle(
                  message: docs[index]['text']??'',
                  username: docs[index]['username']??'',
                  userImage:docs[index]['userImage']??'',
                  isMe: docs[index]['userId']==auth!.uid,
                   key: ValueKey(docs[index].id)
              );
      },
    );
  }
    );}}
