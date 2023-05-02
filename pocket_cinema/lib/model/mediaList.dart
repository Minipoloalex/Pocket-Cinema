import 'package:cloud_firestore/cloud_firestore.dart';

class MediaList{
  final String name;
  final List mediaIds;
  Timestamp createdAt;

  MediaList({required this.name, required this.mediaIds, required this.createdAt});

  Map<String, dynamic> toJson() => {
    'name': name,
    'mediaIds': mediaIds,
  };
}