import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'upload_post.dart';
import 'profile_screen.dart';
import '../models/post_model.dart';

class HomeScreen extends StatelessWidget {
  final postsRef = FirebaseFirestore.instance.collection('posts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feed"),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: postsRef.orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final docs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              final post = PostModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
              return ListTile(
                leading: Image.network(post.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                title: Text(post.caption),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("By ${post.author}"),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.thumb_up, color: Colors.blue),
                          onPressed: () async {
                            await postsRef.doc(post.id).update({'likes': post.likes + 1});
                          },
                        ),
                        Text("${post.likes} Likes"),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => UploadPost())),
      ),
    );
  }
}

