import 'dart:convert';

import 'package:to_do_list/model/content_model.dart';

class Notes {
  final int id;
  final String title;
  final Content content;
  final String createdAt;

  Notes({required this.createdAt, required this.id, required this.title, required this.content});

  factory Notes.fromJson(Map<String, dynamic> jsonData) {
    return Notes(
      id: jsonData['id'],
      title: jsonData['title'], 
      content: Content.fromJson(jsonDecode(jsonData['content'])),
      createdAt: jsonData['created_at']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'title': title,
      'content': content.toJson(),
      'created_at': createdAt
    };
  }
}
