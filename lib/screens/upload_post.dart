import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UploadPost extends StatefulWidget {
  @override
  State<UploadPost> createState() => _UploadPostState();
}

class _UploadPostState extends State<UploadPost> {
  File? _image;
  final captionController = TextEditingController();

  Future pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _image = File(picked.path));
    }
  }

  Future uploadPost() async {
    if (_image == null) return;

    final user = FirebaseAuth.instance.currentUser!;
    final ref = FirebaseStorage.instance.ref().child('posts/${DateTime.now()}.jpg');
    await ref.putFile(_image!);
    final url = await ref.getDownloadURL();

    await FirebaseFirestore.instance.collection('posts').add({
      'imageUrl': url,
      'caption': captionController.text,
      'author': user.email ?? 'Unknown',
      'timestamp': Timestamp.now(),
      'likes': 0,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Post")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _image != null
                ? Image.file(_image!, height: 150)
                : Placeholder(fallbackHeight: 150),
            ElevatedButton(onPressed: pickImage, child: Text("Pick Image")),
            TextField(controller: captionController, decoration: InputDecoration(labelText: "Caption")),
            ElevatedButton(onPressed: uploadPost, child: Text("Post")),
          ],
        ),
      ),
    );
  }
}
