import 'dart:async';

import 'package:chat/widgets/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../themes.dart';
import '../widgets/chat/message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseMessaging fbm =FirebaseMessaging.instance;
  @override
  void initState() {
fbm.getToken().then((token) =>
    print('the token of phone : '+token!),
);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor:  blueBlackColor,
        centerTitle: true,
        title: const Text(
          "Chat",
          style: TextStyle(color: Colors.white,fontSize: 22,letterSpacing:1,fontWeight: FontWeight.bold),
        ),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: const Padding(padding:EdgeInsets.symmetric(vertical: 15,horizontal: 20),child: Icon(Icons.more_vert_rounded,color: Colors.white,size: 30,)),
            items: [
              DropdownMenuItem(value:'logout' ,child:Row(
                children: const [
                  Icon(Icons.exit_to_app_outlined,color: blueBlackColor ,),
                  SizedBox(width:8 ,),
                  Text("Logout",style: TextStyle(color:  blueBlackColor),),
                ],
              ) ,)
            ],
            onChanged: (val) {
              if(val=='logout'){
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Column(
        children: const [
          Expanded(child: Message()),
          NewMessage(),
        ],
      ),
    );
  }
}
