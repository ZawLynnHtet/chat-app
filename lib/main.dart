import 'dart:io';

import 'package:chit_chat/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'compoments/message.dart';
import 'pages/choose_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:cupertino_icons/cupertino_icons.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
          FirebaseAuth.instance.currentUser == null ? ChooseForm() : HomePage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final firestore = FirebaseFirestore.instance;
  TextEditingController msgCtrl = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool showEmoji = false;
  bool showMenu = true;

  getMessage() async {
    await for (var snapshot in firestore.collection('chat35').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      print("Onfocus: >>>> ${focusNode.hasFocus}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showMenu = true;
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () {
          if (showEmoji) {
            setState(() {
              showEmoji = !showEmoji;
            });
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 10,
            title: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfXpi1Nrns6Lg_qmU2V4jJ4kexQbqsgKyCxg&usqp=CAU"),
                ),
                SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "John",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Active Now",
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                    )
                  ],
                )
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.phone,
                    size: 20,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.video,
                    size: 20,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.circleInfo,
                    size: 20,
                  )),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                    stream: firestore
                        .collection('chat35')
                        .orderBy('message', descending: true)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      List<MessageBubble> messages = [];

                      if (snapshot.hasData) {
                        for (var message in snapshot.data!.docs) {
                          MessageBubble mybubble = MessageBubble(
                            message: message['message'],
                            sender: message['sender'],
                            isMe: FirebaseAuth.instance.currentUser!.email ==
                                    message['sender']
                                ? true
                                : false,
                          );

                          messages.add(mybubble);
                        }
                      }

                      return ListView(reverse: true, children: messages);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    showMenu == true
                        ? Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.grid_view_rounded,
                                      color: Colors.blue, size: 20)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(FontAwesomeIcons.camera,
                                      color: Colors.blue, size: 20)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(FontAwesomeIcons.image,
                                      color: Colors.blue, size: 20)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(FontAwesomeIcons.microphone,
                                      color: Colors.blue, size: 20)),
                            ],
                          )
                        : IconButton(
                            onPressed: () {
                              showMenu = true;
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.blue,
                            )),
                    Expanded(
                        child: TextField(
                      focusNode: focusNode,
                      onTap: () {
                        showMenu = false;
                        if (showEmoji) {
                          setState(() {
                            showEmoji = !showEmoji;
                          });
                        }
                      },
                      onSubmitted: (value) async {
                        await firestore.collection('chat35').add({
                          'sender': FirebaseAuth.instance.currentUser!.email,
                          'message': msgCtrl.text
                        });
                        getMessage();
                        msgCtrl.clear();
                        setState(() {});
                      },
                      controller: msgCtrl,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          fillColor: Colors.black12,
                          filled: true,
                          hintText: 'Aa',
                          suffixIcon: IconButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                showEmoji = !showEmoji;
                                setState(() {});
                              },
                              icon: Icon(FontAwesomeIcons.faceSmile,
                                  color: Colors.blue, size: 20)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none)),
                    )),
                    IconButton(
                        onPressed: () async {
                          await firestore.collection('chat35').add({
                            'sender': FirebaseAuth.instance.currentUser!.email,
                            'message': msgCtrl.text
                          });
                          getMessage();
                          msgCtrl.clear();
                          setState(() {});
                        },
                        icon: Icon(FontAwesomeIcons.solidPaperPlane,
                            color: Colors.blue, size: 20))
                  ],
                ),
              ),
              if (showEmoji)
                SizedBox(
                  height: MediaQuery.of(context).size.height * .35,
                  child: EmojiPicker(
                    textEditingController: msgCtrl,
                    config: Config(
                      columns: 7,
                      initCategory: Category.SMILEYS,
                      emojiSizeMax: 32 * (Platform.isAndroid ? 1.0 : 1.0),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
