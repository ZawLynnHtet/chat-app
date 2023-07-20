import 'dart:core';
import 'dart:io';

import 'package:chit_chat/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final storageRef = FirebaseStorage.instance.ref();
  User? currentUser;
  User user = FirebaseAuth.instance.currentUser!;

  File? _image;
  String? downloadUrl;
  final _picker = ImagePicker();


  

  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      print("image path----------");
      _image = File(pickedImage.path);
      final storageRef =
          FirebaseStorage.instance.ref().child('images/profile.png');

      await storageRef.putFile(_image!);
      print("URL*********");
      final downloadUrl = await storageRef.getDownloadURL();
      print(downloadUrl);
      final fullpath = storageRef.fullPath;
      print(fullpath);
      final ref = FirebaseFirestore.instance.collection('users');

      await ref.add({
        "profil": downloadUrl,
        "fullpath": fullpath,
        "time": Timestamp.now()
      });

      setState(() {});
    }
    user.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 120,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await _openImagePicker();
                              setState(() {});
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: _image != null
                                    ? CachedNetworkImage(
                                        imageUrl: downloadUrl.toString(),
                                        placeholder: (context, url) => CircularProgressIndicator(),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                    )
                                    : Image.asset("images/avatar.png"),
                              ),
                            ),
                          ),
                          Text("Name"),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Icon(
                          FontAwesomeIcons.circlePlus,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
        SizedBox(
          height: 500,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 3,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const ChatPage();
                    }));
                  },
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfXpi1Nrns6Lg_qmU2V4jJ4kexQbqsgKyCxg&usqp=CAU"),
                              fit: BoxFit.cover)),
                    ),
                    title: Text("Name"),
                    subtitle: Text("8 Am"),
                    trailing: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSfXpi1Nrns6Lg_qmU2V4jJ4kexQbqsgKyCxg&usqp=CAU",
                        width: 20,
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
