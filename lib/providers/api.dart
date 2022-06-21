import 'dart:io';

import 'package:book_library_flutter/models/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class Api extends ChangeNotifier {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('books');

  final Reference storage = FirebaseStorage.instance.ref();

  List<Book> books = [];

  bool isLoading = true;

  void fetchData(String filter) async {
    print(storage.fullPath);

    final result =
        await collectionReference.orderBy(filter, descending: false).get();

    // print(bookFromJson(result.docs)[0].title);
    // print(result.docs[0].id);
    books = bookFromJson(result.docs);
    // filter == 'title'
    //     ? books.sort(
    //         ((a, b) => a.title.compareTo(b.title)),
    //       )
    //     : books.sort(
    //         ((a, b) => a.genre.compareTo(b.genre)),
    //       );
    isLoading = false;
    notifyListeners();
  }

  void updateImage1(String id, XFile img1) async {
    print(id);
    final imageLink = await uploadImage(img1);
    await collectionReference.doc(id).update({'image1': imageLink});
    fetchData('title');
  }

  void updateImage2(String id, XFile img2) async {
    final imageLink = await uploadImage(img2);
    await collectionReference.doc(id).update({'image2': imageLink});
    fetchData('title');
  }

  Future<String> uploadImage(XFile img) async {
    final result =
        await storage.child('/${DateTime.now()}').putFile(File(img.path));
    print(result.metadata);
    return await result.ref.getDownloadURL();
  }
}
