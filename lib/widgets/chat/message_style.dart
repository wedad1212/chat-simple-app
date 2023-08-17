import 'package:flutter/material.dart';

import '../../themes.dart';

class MessageStyle extends StatelessWidget {
  final String message;
  final String username;
  final bool isMe;
  final Key key;
  final String userImage;

  const MessageStyle(
      {required this.message,
      required this.username,
      required this.isMe,
      required this.key, required this.userImage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [


       Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
        children:[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            width: 150,
            height: 60,
            decoration: BoxDecoration(
                color: isMe ? blueBlackColor : bronColor,
                borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(15),
                  topLeft: const Radius.circular(15),
                  bottomRight:
                  isMe ? const Radius.circular(15) : const Radius.circular(0),
                  bottomLeft:
                  isMe ? const Radius.circular(0) : const Radius.circular(15),
                )),
            child: Column(
              crossAxisAlignment:isMe? CrossAxisAlignment.start:CrossAxisAlignment.end,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white54,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  message,
                  style: const TextStyle(
                    // fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 15,
                  ),

                ),
              ],
            ),
          ),
        ],
    ),
        Positioned(
          top: -15,
        left:isMe? 120:null ,
        right: !isMe?120:null,
        child: CircleAvatar(
          radius: 25,
backgroundImage: NetworkImage(userImage),
        )),

      ],
    );


  }
}
