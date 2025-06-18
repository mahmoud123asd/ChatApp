import 'package:chat_app/cuibts/register_cubit/register_cubit.dart';
import 'package:chat_app/helpers/constants.dart';
import 'package:chat_app/helpers/show_snack_bar.dart';
import 'package:chat_app/widgets/custome_button.dart';
import 'package:chat_app/widgets/custome_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          loading = true;
        } else if (state is RegisterSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              'chat', (route) => false,
              arguments: email.text);
          loading = false;
        } else if (state is RegisterFailure) {
          loading = false;
          showSnackBar(context: context, content: state.errorMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: loading,
          progressIndicator: CircularProgressIndicator(
            color: kprimarycolor,
          ),
          child: Scaffold(
            body: Form(
              key: formkey,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Image.asset(
                            'assets/images/chat96.png',
                            width: 180,
                            height: 150,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Center(
                          child:
                              Text("You and Your friends are always Connected ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xff696969),
                                    fontSize: 15,
                                  )),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Email',
                          textAlign: TextAlign.start,
                        ),
                        Custometextformfield(
                          txt: 'Enter Email',
                          textcontrol: email,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text('Password'),
                        Custometextformfield(
                          txt: 'Enter Password',
                          textcontrol: password,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: CustomeButton(
                            text: 'Sign Up',
                            color: kprimarycolor,
                            textColor: Colors.white,
                            onTap: () async {
                              if (formkey.currentState!.validate()) {
                                BlocProvider.of<RegisterCubit>(context)
                                    .registerUser(
                                        email: email.text,
                                        password: password.text);
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?"),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed('signin');
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: kprimarycolor,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
