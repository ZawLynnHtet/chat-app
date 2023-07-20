import 'package:chit_chat/compoments/chat_list.dart';
import 'package:chit_chat/pages/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  PageController page = PageController();

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
    page.jumpToPage(index);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: SafeArea(
        child: Drawer(
          backgroundColor: const Color.fromARGB(255, 122, 141, 174),
          child: Column(
            children: [
              DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 1, 54, 56),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Icon(
                        FontAwesomeIcons.userTie,
                        size: 50,
                        color: Colors.white,
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )
                    ],
                  )),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.person),
                title: const Text("account"),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.settings),
                title: const Text("settings"),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.settings_accessibility),
                title: const Text("tools"),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(Icons.help_center),
                title: const Text("help center"),
              ),
              ListTile(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const SignIn();
                  }));
                },
                leading: const Icon(Icons.logout),
                title: const Text("logout"),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Chats"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.camera,
                size: 20,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.pencil,
                size: 20,
              ))
        ],
      ),
      body: Column(
        children: [ChatList()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14.0,
        unselectedFontSize: 12.0,
        unselectedLabelStyle: const TextStyle(
          fontSize: 12.0,
        ),
        selectedItemColor: Colors.blue[700],
        unselectedItemColor: Colors.black38,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidComment), label: "Chats"),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.video), label: "Calls"),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.userGroup), label: "People"),
          BottomNavigationBarItem(
              icon: Icon(Icons.horizontal_split_rounded), label: "Stories"),
        ],
        currentIndex: currentIndex,
        onTap: onTap,
      ),
    );
  }
}
