import 'package:chat_app/cuibts/login_cubit/login_cubit.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/sign_in_page.dart';
import 'package:chat_app/pages/sing_up_page.dart';
import 'package:chat_app/pages/splash_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
      print('User email: ${user.email}');
    } else {
      print('User signed out');
    }
  });
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: (FirebaseAuth.instance.currentUser != null)
            ? ChatPage()
            : SplashPage(),
        routes: {
          "signin": (context) => SignInPage(),
          "signup": (context) => SignUpPage(),
          "chat": (context) => ChatPage(),
          "homepage": (context) => HomePage(),
        },
      ),
    );
  }
}
