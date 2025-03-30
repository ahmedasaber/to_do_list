import 'package:flutter/cupertino.dart';
import 'package:to_do_list/services/database_service.dart';

import '../model/notes_model.dart';

class NoteProvider extends ChangeNotifier{

  List<Notes> _notes = [];

  List<Notes> get notes => _notes;

  SqlDatabase db = SqlDatabase();

  Future<void> getNotes() async{
    _notes = await db.getData("select * from notes ORDER BY created_at DESC");
    notifyListeners();
  }

  Future<void> insertNote({required String title, required String content}) async{
    await db.insetData("""
      insert into notes (title, content, created_at) 
      values ('$title','$content', '${DateTime.now()}')
    """);
  }
  Future<void> updateNote({required int id,required String title, required String content})async{
    await db.updateData("""
      update notes
      set title = '$title', content = '$content'
      where id = $id
    """);
  }
  Future<void> deleteNote({required int id})async{
    await db.deleteData("""
      delete from notes where id = $id
    """);
  }
}