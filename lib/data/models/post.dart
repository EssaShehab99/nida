import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String? id;
  final String title;
  final String details;
  DocumentReference? reference;
  Post({required this.id, required this.title, required this.details});

  factory Post.fromJson(Map<String, dynamic> json,String id) =>
      Post(id: id, title: json["title"], details: json["details"]);

  Map<String, dynamic> toJson() => <String, dynamic>{
        "title": title,
        "details": details,
      };
  factory Post.fromSnapshot(DocumentSnapshot snapshot) {
    final post = Post.fromJson(snapshot.data() as
    Map<String, dynamic>,snapshot.id);
    post.reference = snapshot.reference;
    return post;
  }
}
