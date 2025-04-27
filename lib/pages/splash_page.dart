import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed('homepage');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      color: Colors.white,
                      child: Image.asset(
                        "assets/images/chat96.png",
                        height: 180,
                        width: 180,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                const Text("Developed By Mahmoud ElSayid",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
