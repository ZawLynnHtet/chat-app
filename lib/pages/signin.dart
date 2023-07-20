import 'package:chit_chat/pages/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../auth_service.dart';
import 'home.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isChecked = false;
  bool showPassword = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  User? currentUser;
  String errorMessage = '';

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
      body: Padding(
        padding:
            const EdgeInsets.only(right: 15, left: 15, top: 50, bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Column(
              children: [
                Text(
                  "Hello Again!👋",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                ),
                Text(
                  "Welcome back you've been missed!",
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
                      obscureText: showPassword,
                      keyboardType: TextInputType.visiblePassword,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                activeColor: Colors.blue,
                                value: isChecked,
                                onChanged: (bool? newValue) {
                                  isChecked = newValue!;
                                  setState(() {});
                                }),
                            const Text("Remember me"),
                          ],
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text("Forget password"))
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
                            print(">>>>>>> Signing in");

                            print(email.text);
                            print(password.text);

                            final credential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email.text, password: password.text);
                            print("Credential");

                            print("OKKKKK");
                            // ignore: unnecessary_null_comparison
                            if (credential == null) {
                              print("NUll");
                            } else {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return const HomePage();
                              }));
                            }
                            print(credential);
                          } on FirebaseException catch (e) {
                            if (e.code == 'user-not-found') {
                              errorMessage = 'No user found for that email.';
                              print("Not found");
                            } else if (e.code == 'wrong-password') {
                              errorMessage =
                                  'Wrong password provided for that user.';
                              print("Wrong password");
                            } else {
                              errorMessage = e.code;
                              print(e);
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(e.toString())));
                            // } finally {

                            //   print(">>>>>>> Finally");
                            //   Navigator.pushReplacement(context, MaterialPageRoute(
                            //       builder: (BuildContext context) {
                            //         return const HomePage();
                            //   }));
                          }
                        },
                        child: const Text(
                          "Sign In",
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
                          "Or Sign In With",
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
                          onTap: () {
                            print(currentUser);
                          },
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
                          onTap: () async {
                            var token = await AuthService().signInWithGoogle();
                            print("_____________:>>>>$token");
                            User? user = FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return const HomePage();
                              }));
                              setState(() {});
                            }
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
                  "Don't have an account?",
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const Register();
                      }));
                    },
                    child: const Text("Register Now"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
