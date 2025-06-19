import 'package:chat_app/cuibts/chat_cubit/chat_cubit.dart';
import 'package:chat_app/helpers/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  ChatPage({
    super.key,
  });

  List<MessageModel> messageslist = [];
  TextEditingController controller = TextEditingController();
  ScrollController scrollcontrol = ScrollController();

  @override
  Widget build(BuildContext context) {
    //String email = ModalRoute.of(context)!.settings.arguments as String;
    // Get the current user's email
    String? userEmail = FirebaseAuth.instance.currentUser?.email;
    String? email;
    if (userEmail != null) {
      email = userEmail;
    }
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/chat46.png',
                height: 40,
              ),
              Text(
                " Chat",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacementNamed('homepage');
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: kprimarycolor,
                  size: 30,
                ))
          ],
        ),
        body: Column(children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                BlocProvider.of<ChatCubit>(context).getMessages();
                messageslist = BlocProvider.of<ChatCubit>(context).messageslist;
                return ListView.builder(
                  reverse: true,
                  controller: scrollcontrol,
                  itemCount: messageslist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return (messageslist[index].id == email)
                        ? ChatBubble(
                            message: messageslist[index].message,
                          )
                        : ChatBubbleForFriend(
                            message: messageslist[index].message);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                controller: controller,
                onSubmitted: (value) {
                  BlocProvider.of<ChatCubit>(context)
                      .sendMessage(message: value, email: email!);
                  controller.clear();
                  scrollcontrol.animateTo(
                    0,
                    duration: Duration(microseconds: 500),
                    curve: Curves.easeIn,
                  );
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white54,
                  hintText: "send message",
                  hintStyle: TextStyle(color: Colors.black),
                  suffixIcon: IconButton(
                    onPressed: () {
                      BlocProvider.of<ChatCubit>(context)
                          .sendMessage(message: controller.text, email: email!);
                      controller.clear();
                      scrollcontrol.animateTo(
                        0,
                        duration: Duration(microseconds: 500),
                        curve: Curves.easeIn,
                      );
                    },
                    icon: Icon(Icons.send),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide:
                          BorderSide(color: Color(0xff2d9cfc), width: 2)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide:
                          BorderSide(width: 2, color: Color(0xfff2f4f5))),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100),
                    borderSide: BorderSide(
                      color: Colors.grey, // Set border color for enabled state
                    ),
                  ),
                )),
          )
        ]));
  }
}
