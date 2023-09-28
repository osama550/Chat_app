import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/components/constants.dart';
import 'package:untitled/models/message_modle.dart';

Widget defultTextFormFiled({
  String? hintText,
  Color? textcolor = Colors.white,
  bool obscure =false,
  Function(String)? onchange,
}) =>
    TextFormField(
  obscureText: obscure,
      validator: (value){
        if(value!.isEmpty){
          return "value is wrong";
        }
      },
      onChanged: onchange,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: textcolor,
          ),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
    );
Widget defaultButton({
  double width = double.infinity,
  required String? text,
  VoidCallback? onTap,
}) =>
    GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          height: 60,
          width: width,
          child: Center(child: Text(text!))),
    );
Widget defultChatBuble({
  required Message message
})=>Align(
  alignment: Alignment.centerLeft,
  child:   Container(
    margin: EdgeInsets.all(8),

    padding:EdgeInsets.only(
      top: 20,
      bottom: 20,
      right: 16.0,
      left: 16.0
    ),

    decoration: const BoxDecoration(

      borderRadius: BorderRadius.only(

        topLeft:Radius.circular(20) ,

        topRight: Radius.circular(20),

        bottomRight:Radius.circular(20) ,

      ),

      color: kBackGroundColor,

    ),



    child: Text(
        message.message,

        style: TextStyle(

          color: kTextColor,

        )),

  ),
);
Widget defultChatBubleForFriend({
  required Message message
})=>Align(
  alignment: Alignment.centerRight,
  child:   Container(
    margin: EdgeInsets.all(8),

    padding:EdgeInsets.only(
        top: 20,
        bottom: 20,
        right: 16.0,
        left: 16.0
    ),

    decoration: const BoxDecoration(

      borderRadius: BorderRadius.only(

        topLeft:Radius.circular(20) ,

        topRight: Radius.circular(20),

        bottomLeft:Radius.circular(20) ,

      ),

      color: Color(0xff006D84),

    ),



    child: Text(
        message.message,

        style: TextStyle(

          color: kTextColor,

        )),

  ),
);