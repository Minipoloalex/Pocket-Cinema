import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pocket_cinema/model/media.dart';

class MediaList{
  final String name;
  final List<Media> media;
  Timestamp createdAt;

  MediaList({required this.name, required this.media, required this.createdAt});

  Map<String, dynamic> toJson() => {
    'name': name,
    'media': media,
  };
}