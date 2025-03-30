import 'package:to_do_list/model/check_list_model.dart';

class Content {
  final String type;
  final dynamic note;

  Content({required this.type, required this.note});

  factory Content.fromJson(Map<String, dynamic> jsonData) {
    if(jsonData['type'] == 'checklist'){
      return Content(
        type: jsonData['type'],
        note: List.of(jsonData['content']).map((e)=>CheckListItems.fromJson(e)).toList(),
      );
    }
    return Content(
      type: jsonData['type'],
      note: jsonData['content']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'type': type,
      'note': type == 'checklist'
        ? List<CheckListItems>.of(note).map((e)=> e.toJson()).toList()
        : note,
    };
  }
}
