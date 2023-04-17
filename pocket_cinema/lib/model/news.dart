import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class News {
  final String title;
  final String description;
  final String image;
  final DateTime date;

  News({
    required this.title,
    required this.description,
    required this.image,
    required this.date,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'],
      description: json['description'],
      image: json['image'],
      date: DateFormat('E, d MMM yyyy hh:mm:ss Z', 'en_US').parse(json['date']),
    );
  }
}
