// import 'package:chat_app/cuibts/chat_cubit/chat_cubit.dart';
// import 'package:chat_app/helpers/constants.dart';
// import 'package:chat_app/models/message_model.dart';
// import 'package:chat_app/widgets/chat_body.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ChatPage extends StatelessWidget {
//   ChatPage({super.key});

//   TextEditingController controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ChatCubit, ChatState>(
//       listener: (context, state) {
//         if (state is ChatSuccess) {
//           List<MessageModel> messageslist = state.messages;
//         }
//       },
//       builder: (context, state) {
//         return ChatBody(
//             messageslist: messageslist,
//             controller: controller,
//             messages: messages);
//         ;
//       },
//     );
//   }
// }
