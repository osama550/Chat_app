import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/components/components.dart';
import 'package:untitled/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/cubit/chat/chat_cubit.dart';
import 'package:untitled/cubit/register/register_cubit.dart';
import 'package:untitled/models/message_modle.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, required this.email});

  final String email;
  static String id = "ChatScreen";
  final _controller = ScrollController();
  TextEditingController controller = TextEditingController();
  List<Message> messagesList = [];


  @override
  Widget build(BuildContext context) {
    var cubit = ChatCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kBackGroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(kLogo, height: 50),
            const Text('Chat'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if(state is ChatSuccessState){
                  messagesList=cubit.messagesList;

                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == email ?
                    defultChatBuble(message: messagesList[index])
                        : defultChatBubleForFriend(
                        message: messagesList[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                cubit.sendMessage(message: data, email: email);
                controller.clear();
                _controller.animateTo(
                  0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              },
              decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.send,
                    color: kBackGroundColor,
                  ),
                  hintText: "Send Message",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                    const BorderSide(color: kBackGroundColor),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

//osamakamel758@gmail.com
//123456789
