import 'package:chit_chat/auth_service.dart';
import 'package:chit_chat/pages/signin.dart';
import 'package:chit_chat/pages/verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isChecked = false;
  bool showPassword = true;
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? currentUser;

  checkToken() async {
    currentUser = await FirebaseAuth.instance.currentUser;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkToken();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding:
            const EdgeInsets.only(right: 15, left: 15, top: 50, bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Column(
              children: [
                Text(
                  "Create an account",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                ),
                Text(
                  "Connect with your friends!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                )
              ],
            ),
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Phone Number",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    TextFormField(
                      controller: phone,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          hintText: 'Enter your phone number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Email Address",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    TextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Enter your email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Password",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                    TextFormField(
                      controller: password,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: showPassword,
                      decoration: InputDecoration(
                          hintText: 'Enter your password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              icon: showPassword
                                  ? const Icon(
                                      FontAwesomeIcons.eyeSlash,
                                      size: 20,
                                    )
                                  : const Icon(
                                      FontAwesomeIcons.eye,
                                      size: 20,
                                    ))),
                    ),
                    Row(
                      children: [
                        Checkbox(
                            activeColor: Colors.blue,
                            value: isChecked,
                            onChanged: (bool? newValue) {
                              isChecked = newValue!;
                              setState(() {});
                            }),
                        const Text("I agree to the terms and conditions"),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize:
                                Size(MediaQuery.of(context).size.width, 50),
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        onPressed: () async {
                          try {
                            final credential =
                                await auth.createUserWithEmailAndPassword(
                              email: email.text,
                              password: password.text,
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              print(
                                  'The account already exists for that email.');
                            }
                          } catch (e) {
                            print(e);
                          } finally {
                            FirebaseAuth.instance.currentUser!.sendEmailVerification();
                            debugPrint('email verification');
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
                              return const VerifyPage();
                            }));
                          }
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 2,
                          color: Colors.black26,
                        ),
                        const Text(
                          "Or Register With",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Container(
                          width: 100,
                          height: 2,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                              alignment: Alignment.center,
                              width: 170,
                              height: 60,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black26, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "images/facebook.png",
                                    width: 30,
                                  ),
                                  const Text(
                                    "Facebook",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )),
                        ),
                        GestureDetector(
                          onTap: () {
                            AuthService().signInWithGoogle();
                            setState(() {});
                          },
                          child: Container(
                              width: 170,
                              height: 60,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black26, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "images/google.png",
                                    width: 30,
                                  ),
                                  const Text(
                                    "Google",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const SignIn();
                      }));
                    },
                    child: const Text("Sign In"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
