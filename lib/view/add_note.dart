import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/model/check_list_model.dart';
import 'package:to_do_list/viewmodel/notes_viewmodel.dart';
import 'home_page.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool isCheckList = false;
  bool checkBox = false;

  List<CheckListItems> fields = List.empty(growable: true);

  Map<String,dynamic> contentType = {};

  NoteProvider  noteProvider = NoteProvider();
  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {},
              icon: ImageIcon(AssetImage('icons/undo.png')),
            ),
            IconButton(
              onPressed: () {},
              icon: ImageIcon(AssetImage('icons/redo.png')),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: (){
              if(isCheckList){
                print('ffffffffffffffffffffff$fields');
                contentType = {'type': 'checklist', 'content': fields};
                String content = jsonEncode(contentType);
                noteProvider.insertNote(title: _titleController.text, content: content);
              }else{
                contentType = {'type': 'text', 'content': _contentController.text};
                String content = jsonEncode(contentType);
                noteProvider.insertNote(title: _titleController.text, content: content);
              }
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false,);
            }, icon: Icon(CupertinoIcons.checkmark)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: TextStyle(fontSize: 20, fontWeight:FontWeight.bold, ),
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(fontSize: 24, color: Colors.grey[600]),
                  border: InputBorder.none,
                ),
              ),
              isCheckList
                  ? Column(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: fields.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Row(
                        children: [
                          IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.drag_indicator, color: Colors.black45,),
                            visualDensity: VisualDensity.compact,
                          ),
                          Checkbox(
                            side: BorderSide(color: Colors.black45),
                            shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                            ),
                            onChanged: (isChanged){
                              setState(() {
                                fields[i].checked = isChanged!;
                              });
                            },
                            value: fields[i].checked,
                          ),
                          Expanded(
                            child: TextField(
                              maxLines: null,
                              style: TextStyle(fontSize: 14),
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                border: InputBorder.none
                              ),
                              onChanged: (currTask){
                                fields[i].task = currTask;
                              },
                            ),
                          ),
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            onPressed: (){
                              setState(() {
                                fields.removeAt(i);
                                print(fields);
                              });
                            }, icon: Icon(CupertinoIcons.xmark)
                          ),
                        ],
                      );
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        fields.add(CheckListItems(task: '', checked: false));
                        print(fields);
                        print(fields.length);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          SizedBox(width: 31),
                          Icon(Icons.add, size: 24),
                          SizedBox(width: 10),
                          Text("Add new", style: TextStyle( fontSize: 16)),
                        ],
                      ),
                    ),
                  )
                ],
              )
                  : TextField(
                controller: _contentController,
                style: TextStyle(fontSize: 16),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                //textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  constraints: BoxConstraints(minHeight: 550),
                  hintText: 'Note',
                  hintStyle: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: Icon(Icons.add_box_outlined), onPressed: () {
              setState(() {
                isCheckList =true;
              });
            }),
            SizedBox(width: 10), // Space for FAB
            IconButton(icon: Icon(Icons.color_lens_outlined), onPressed: () {}),
            SizedBox(width: 10), // Space for FAB
            IconButton(icon: Icon(Icons.format_color_text), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
