// import 'dart:async';
//
// import 'package:nida/data/models/post.dart';
// import 'package:nida/data/network/repository.dart';
//
// class MemoryRepository extends Repository{
//   Stream<List<Post>>? _postStream;
//   final StreamController _postStreamController =StreamController<List<Post>>();
//
//   @override
//   Stream<List<Post>> watchAllPosts() {
//     _postStream ??= _postStreamController.stream as Stream<List<Post>>;
// return _postStream!;
//   }
//
//
//   @override
//   Future init() {
//     return Future.value();
//   }
//   @override
//   void close() {
//     _postStreamController.close();
//   }
//
// }