import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/cubit/chat/chat_cubit.dart';
import 'package:untitled/cubit/login/login_cubit.dart';
import 'package:untitled/cubit/register/register_cubit.dart';
import 'package:untitled/screens/chat_screen.dart';
import 'package:untitled/screens/login_screen.dart';
import 'package:untitled/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit()..getMessage(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}


//Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp(
//  );