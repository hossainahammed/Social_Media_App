import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String imageUrl;
  final String caption;
  final String author;
  final int likes;
  final DateTime timestamp;

  PostModel({
    required this.id,
    required this.imageUrl,
    required this.caption,
    required this.author,
    required this.likes,
    required this.timestamp,
  });

  factory PostModel.fromMap(Map<String, dynamic> data, String docId) {
    return PostModel(
      id: docId,
      imageUrl: data['imageUrl'] ?? '',
      caption: data['caption'] ?? '',
      author: data['author'] ?? 'Unknown',
      likes: data['likes'] ?? 0,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'caption': caption,
      'author': author,
      'likes': likes,
      'timestamp': timestamp,
    };
  }
}
