import 'package:chat_app/helpers/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chat_body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MessageModel> messageslist = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageslist.add(MessageModel.fromjson(snapshot.data!.docs[i]));
            }
            return ChatBody(
                messageslist: messageslist,
                controller: controller,
                messages: messages);
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: kprimarycolor,
                backgroundColor: Colors.white,
              ),
            );
          }
        });
  }
}
