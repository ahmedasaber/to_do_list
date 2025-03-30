class CheckListItems{
   String task;
   bool checked;

  CheckListItems({required this.task, required this.checked});

  factory CheckListItems.fromJson(Map<String, dynamic> jsonData){
    return CheckListItems(
      task: jsonData['task'],
      checked: jsonData['checked']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'task': task,
      'checked': checked
    };
  }
}