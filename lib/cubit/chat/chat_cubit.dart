import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled/components/constants.dart';
import 'package:untitled/models/message_modle.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  static ChatCubit get(context) => BlocProvider.of(context);

  List<Message> messagesList = [];
  CollectionReference messages =
  FirebaseFirestore.instance.collection(kMessagesCollections);

  void sendMessage({
    required String message,
    required String email,

}){
    messages.add({
      kMessage: message,
      kCreatedAt: DateTime.now(),
      "id": email
    });
  }
void getMessage(){


  messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
    messagesList.clear();
    for(var doc in event.docs){
      messagesList.add(Message.fromJson(doc));
      print("555555555555555");

    }
    emit(ChatSuccessState(messages:messagesList));
  });
}
}
