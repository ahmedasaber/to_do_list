import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/custom_shape.dart';
import 'package:to_do_list/db.dart';
import 'package:to_do_list/home_page.dart';
import 'package:to_do_list/model.dart';

class EditNote extends StatefulWidget {
  final int id;
  final String title;
  final String content;
  final String createAt;

  const EditNote({super.key, required this.title, required this.content, required this.id, required this.createAt});

  @override
  State<EditNote> createState() => _TaskState();
}

class _TaskState extends State<EditNote> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool isCheckList = false;
  bool checkBox = false;
  List items = [];

  List<dynamic> fields = List.empty(growable: true);

  Map<String, dynamic> content = {};

  Map<String,dynamic> contentType = {};

  NoteProvider  noteProvider = NoteProvider();

  @override
  void initState() {
    _titleController.text = widget.title;
    content = jsonDecode(widget.content);

    if(content['type'] == 'checklist'){
        isCheckList = true;
        fields = content['content'];
    }else{
      _contentController.text = content['content'];
    }
    super.initState();
  }
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
                  contentType = {'type': 'checklist', 'content': fields};
                  String content = jsonEncode(contentType);
                  noteProvider.updateNote(title: _titleController.text, content: content, id: widget.id);
                }else{
                  contentType = {'type': 'text', 'content': _contentController.text};
                  String content = jsonEncode(contentType);
                  noteProvider.updateNote(id:widget.id, title: _titleController.text, content: content);
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
                            side:BorderSide(color: Colors.black45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                            ),
                            onChanged: (isChanged){
                              setState(() {
                                fields[i]['checked'] = isChanged!;
                              });
                            },
                            value: fields[i]['checked'],
                          ),
                          Expanded(
                            child: TextField(
                              controller: TextEditingController(text: fields[i]['task']),
                              maxLines: null,
                              style: TextStyle(fontSize: 14),
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                              onChanged: (task){
                                fields[i]['task'] = task;
                              },
                            ),
                          ),
                          IconButton(
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
                        fields.add({'task': '', 'checked': false});
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
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.add_box_outlined), onPressed: () {
              if(!isCheckList) {
                if (_contentController.text.isNotEmpty) {
                  List noteTxt = _contentController.text.split('\n');
                  for (var note in noteTxt) {
                    fields.add({'task': note, 'checked': false});
                  }
                  setState(() {
                    isCheckList = true;
                  });
                }
              }

            }),
            IconButton(icon: Icon(Icons.color_lens_outlined), onPressed: () {}), // Space for FAB
            IconButton(icon: Icon(Icons.format_color_text), onPressed: () {}),
            Expanded(
                child: Text(
                  'Created ${DateFormat('MMM dd, yyy').format(DateTime.parse(widget.createAt))}',
                  style: TextStyle(
                    fontSize: 12
                  ),
                )
            ),
            IconButton(icon: Icon(Icons.delete), onPressed: () {
              noteProvider.deleteNote(id: widget.id);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false,);
            }),
          ],
        ),
      ),
    );
  }
}
