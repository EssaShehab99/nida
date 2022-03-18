import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '/data/models/post.dart';
class PostDao extends ChangeNotifier{
  final CollectionReference collection =
  FirebaseFirestore.instance.collection('posts');

  void savePost(Post post) {
    collection.add(post.toJson());
  }
  Stream<QuerySnapshot> getPostsStream() {
    return collection.snapshots();
  }
}
