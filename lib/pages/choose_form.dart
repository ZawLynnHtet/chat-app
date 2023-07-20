import 'dart:async';

import 'package:chit_chat/pages/signin.dart';
import 'package:flutter/material.dart';
import 'register.dart';

class ChooseForm extends StatefulWidget {
  const ChooseForm({super.key});

  @override
  State<ChooseForm> createState() => _ChooseFormState();
}

class _ChooseFormState extends State<ChooseForm> {
  bool register = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 350,
              height: 350,
              child: Image.asset(
                "images/chat.jpg",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 200,
              child: Column(
                children: [
                  Text(
                    "Let's Get Started",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: Text(
                      "Connect with each other with chatting or calling. Enjoy safe and private chatting",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      register = true;
                      setState(() {});
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return const Register();
                        }));
                    },
                    child: Container(
                      width: 170,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: register ? Colors.white70 : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Register",
                        style: TextStyle(
                            color: register ? Colors.black : Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      register = false;
                      setState(() {});
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
                        return const SignIn();
                      }));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 170,
                      height: 60,
                      decoration: BoxDecoration(
                        color: register ? Colors.transparent : Colors.white70,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: register ? Colors.white : Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
