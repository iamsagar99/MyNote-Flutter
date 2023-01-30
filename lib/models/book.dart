import 'package:flutter/material.dart';

class Book with ChangeNotifier {
  final String? title;
  final String? author;
  final String? thumbnailUrl;
  final String? description;


  Book(
      {required this.title,
      required this.author,
      this.thumbnailUrl,
      this.description});
}
