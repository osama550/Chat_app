import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:untitled/components/components.dart';
import 'package:untitled/components/constants.dart';
import 'package:untitled/cubit/register/register_cubit.dart';
import 'package:untitled/helper/show_snap_bar.dart';
import 'package:untitled/screens/chat_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  @override
  String? email, password;
  GlobalKey<FormState> formkey = GlobalKey();

  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    var cubit = RegisterCubit.get(context);
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if(state is RegisterLoadingState){
          isloading=true;
        }else if (state is RegisterSuccessState){
          isloading=false;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  email: email!,
                ),
              ));
        }else if(state is RegisterErrorState){
          isloading = false;
          showsnapbar(context, state.errmessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isloading,
          child: Scaffold(
            backgroundColor: kBackGroundColor,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Image.asset('assets/images/scholar.png'),
                      Text(
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
                      Row(
                        children: [
                          Text(
                            'REGISTER',
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
                                await cubit.registerUser(
                                    email: email!, password: password!);

                            }
                          },
                          text: 'Register'),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            '        already have an account ?',
                            style: TextStyle(color: kTextColor),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Login',
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
