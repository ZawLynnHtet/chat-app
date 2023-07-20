import 'package:chit_chat/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("We've sent verify email link to your email. Please enter your link to verify your account.",
              textAlign: TextAlign.center,),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(onPressed: () async{
                await FirebaseAuth.instance.currentUser!.reload();
        
                if (FirebaseAuth.instance.currentUser!.emailVerified) {
                  // print(">>>>>>> GO to Home")
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
                    return const HomePage();
                  }));
                } else {
                  print(">>>> Please your verify your email.");
                }
              }, child: Text("Verify"))
            ],
          ),
        ),
      ),
    );
  }
}