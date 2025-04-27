import 'package:chat_app/helpers/constants.dart';
import 'package:chat_app/widgets/custome_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Get Started",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
          Text("Start With Signing Up or Sign In",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff696969),
                fontSize: 15,
              )),
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            'assets/images/chat.png',
            width: double.infinity,
            height: 200,
          ),
          const SizedBox(
            height: 70,
          ),
          CustomeButton(
            text: 'Sign Up',
            color: kprimarycolor,
            textColor: Colors.white,
            onTap: () {
              Navigator.of(context).pushNamed('signup');
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CustomeButton(
            text: 'Sign In',
            color: Color(0xfff7f7f7),
            textColor: Colors.black,
            onTap: () {
              Navigator.of(context).pushNamed('signin');
            },
          ),
        ],
      ),
    );
  }

}
