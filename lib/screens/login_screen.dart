import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:untitled/components/components.dart';
import 'package:untitled/components/constants.dart';
import 'package:untitled/cubit/chat/chat_cubit.dart';
import 'package:untitled/cubit/login/login_cubit.dart';
import 'package:untitled/helper/show_snap_bar.dart';
import 'package:untitled/screens/chat_screen.dart';
import 'package:untitled/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey();

  bool isloading = false;
  String? email, password;

  @override
  Widget build(BuildContext context) {
    var cubit = LoginCubit.get(context);
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          isloading = true;
        } else if (state is LoginSuccessState) {
          isloading = false;
          // BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(email: email!),
              ));
        } else if (state is LoginErrorState) {
          isloading = false;
          showsnapbar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isloading,
          child: Scaffold(
            backgroundColor: kBackGroundColor,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Image.asset('assets/images/scholar.png'),
                      const Text(
                        'Scholar Chat',
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'Pacifico',
                          color: kTextColor,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      const Row(
                        children: [
                          Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 20,
                              color: kTextColor,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                      defultTextFormFiled(
                        onchange: (value) {
                          email = value;
                        },
                        hintText: 'Email',
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      defultTextFormFiled(
                        obscure: true,
                        onchange: (value) {
                          password = value;
                        },
                        hintText: 'Password',
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      defaultButton(
                          onTap: () async {
                            if (formkey.currentState!.validate()) {
                              cubit.loginUser(
                                  email: email!, password: password!);
                            }
                          },
                          text: 'LOGIN'),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            '        dont\' have an account ?',
                            style: TextStyle(color: kTextColor),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ));
                            },
                            child: const Text('Register',
                                style: TextStyle(
                                  color: Color(0xffC7EDE6),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }


}
