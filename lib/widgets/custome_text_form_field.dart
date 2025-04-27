import 'package:flutter/material.dart';

class Custometextformfield extends StatefulWidget {
  final String txt;
  final TextEditingController textcontrol;
  const Custometextformfield({
    super.key,
    required this.txt,
    required this.textcontrol,
  });

  @override
  State<Custometextformfield> createState() => _CustometextformfieldState();
}

class _CustometextformfieldState extends State<Custometextformfield> {
  bool isobscure = true;
  late bool ispassword;
  late bool isemail;
  late bool isusername;
  @override
  void initState() {
    ispassword = widget.txt.contains("Password");
    isemail = widget.txt.contains("Email");
    isusername = widget.txt.contains("name");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "this field can't be empty";
          } else {
            return null;
          }
        },
        obscureText: (ispassword) ? isobscure : false,
        obscuringCharacter: '*',
        controller: widget.textcontrol,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white54,
          hintText: widget.txt,
          hintStyle: TextStyle(color: Colors.black),
          prefixIcon: (isemail) ? Icon(Icons.person) : Icon(Icons.lock),
          suffixIcon: (ispassword)
              ? IconButton(
                  enableFeedback: false,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    isobscure = (isobscure) ? false : true;
                    setState(() {});
                  },
                  icon: (isobscure)
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility))
              : null,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide(color: Color(0xff2d9cfc), width: 2)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide(width: 2, color: Color(0xfff2f4f5))),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(
              color: Colors.grey, // Set border color for enabled state
            ),
          ),
        ));
  }
}
