// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<Book> bookFromJson(List str) =>
    List<Book>.from(str.map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  Book({
    required this.id,
    required this.author,
    required this.genre,
    required this.description,
    required this.image1,
    required this.title,
    required this.image2,
  });

  String id;
  String author;
  String genre;
  String description;
  String image1;
  String title;
  String image2;

  factory Book.fromJson(dynamic json) {
    final jsonData = json.data();
    return Book(
      id: json.id,
      author: jsonData["author"],
      genre: jsonData["genre"],
      description: jsonData["description"],
      image1: jsonData["image1"],
      title: jsonData["title"],
      image2: jsonData["image2"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "genre": genre,
        "description": description,
        "image1": image1,
        "title": title,
        "image2": image2,
      };
}
