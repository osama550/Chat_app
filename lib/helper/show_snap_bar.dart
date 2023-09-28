import 'package:flutter/material.dart';

Future<void> showsnapbar(BuildContext context, String message) async {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));
}