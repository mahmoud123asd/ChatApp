import 'package:chat_app/helpers/constants.dart';
import 'package:chat_app/helpers/show_snack_bar.dart';
import 'package:chat_app/widgets/custome_button.dart';
import 'package:chat_app/widgets/custome_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
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
                        "Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                          "Remember to get up & stretch once\n in a while-Your friend at chat",
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
                        text: 'Sign In',
                        color: kprimarycolor,
                        textColor: Colors.white,
                        onTap: () async {
                          if (formkey.currentState!.validate()) {
                            loading = true;
                            setState(() {});
                            try {
                              await loginUser();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  'chat', (route) => false,
                                  arguments: email.text);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found' ||
                                  e.code == 'wrong-password') {
                                showSnackBar(
                                    context: context,
                                    content: 'Wrong email or password');
                              }
                            }
                            loading = false;
                            setState(() {});
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
                        Text("Don't have an account?"),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed("signup");
                          },
                          child: Text(
                            "Sign Up here",
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
  }

  Future<void> loginUser() async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(), password: password.text.trim());
  }
}
