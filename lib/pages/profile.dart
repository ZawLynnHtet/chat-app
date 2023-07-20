import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final storageRef = FirebaseStorage.instance.ref();

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
      final firestore = FirebaseFirestore.instance;
      firestore.collection('chat35').add({'downloadUrl': downloadUrl});
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                await _openImagePicker();
                setState(() {});
              },
              child: Container(
                width: 80,
                height: 80,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: _image != null
                      ? Image.file(_image!, fit: BoxFit.cover)
                      : Image.asset("images/avatar.png"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
