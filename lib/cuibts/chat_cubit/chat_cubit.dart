import 'package:bloc/bloc.dart';
import 'package:chat_app/helpers/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);
  List<MessageModel> messageslist = [];
  void sendMessage({required String message, required String email}) {
    messages.add({
      'message': message,
      'createdAt': DateTime.now(),
      'id': email,
    });
  }

  void getMessages() {
    messages
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((events) {
      messageslist.clear();
      for (var doc in events.docs) {
        messageslist.add(MessageModel.fromjson(doc));
      }
      emit(ChatSuccess(messages: messageslist));
    });
  }
}
