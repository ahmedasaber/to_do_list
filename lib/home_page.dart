import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'custom_shape.dart';
import 'edit_note.dart';
import 'model.dart';
import 'add_note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> colors = ['fff9cb', 'e3e0ff','FFCDD2', 'e0f2ff'];

  Map<String, dynamic> content = {};

  @override
  void initState() {
    Provider.of<NoteProvider>(context, listen: false).getNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        titleSpacing: 0,
        title: ListTile(
          title: Text('Hey 👋', style: TextStyle(fontSize: 12, color: Colors.grey[600]),),
          subtitle: Text('Welcome Back', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black),),
        ),
        actions: [
          Card(
            color: Colors.white,
            elevation: 0,
            margin: EdgeInsets.only(right: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
            ),
            child: IconButton(
              onPressed: (){},
              icon: ImageIcon(AssetImage('icons/search.png'))
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        // Padding(
        //   padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        //   child: Text('data')
        // ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Consumer<NoteProvider>(
                builder: (context, noteProvider, child){
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: noteProvider.notes.length,
                    itemBuilder: (BuildContext context, int i){
                      content = jsonDecode(noteProvider.notes[i]['content']);
                      print(content);
                      print(content.runtimeType);
                      print(content['content '].runtimeType);
                      return Transform.translate(
                        offset: Offset(0, -10.0 * i),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder:
                                    (context)=> EditNote(
                                      id:noteProvider.notes[i]['id'],
                                      title: noteProvider.notes[i]['title'],
                                      content: noteProvider.notes[i]['content'],
                                      createAt: noteProvider.notes[i]['created_at'],
                                    )
                                )
                            );
                          },
                          child: Card(
                            color: Color(int.parse('0XFF${colors[i % 4]}')),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.white, width: 3)
                            ),
                            elevation: 4,
                            margin: EdgeInsets.only(bottom: 15),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${noteProvider.notes[i]['title']}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  ),
                                  SizedBox(height: 5,),
                                  content['type'] == 'checklist'
                                    ? ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemExtent: 22,
                                      itemCount: content['content'].length > 3 ? 3 : content['content'].length,
                                      itemBuilder: (BuildContext context, int i){
                                        return Row(
                                          children: [
                                            Transform.scale(
                                              scale: 0.8,
                                              child: Checkbox(
                                                side: BorderSide(color: Colors.black45, width: 2),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5)
                                                ),
                                                value: content['content'][i]['checked'],
                                                onChanged: (_){}
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${content['content'][i]['task']}",
                                                maxLines: 1,
                                                overflow: i == 2 ? TextOverflow.fade : TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black54
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                      )
                                    : Text(
                                      '${content['content']}',
                                      maxLines: 2,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
                }
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff675dfe),
        shape: CircleBorder(),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNote()));
        },
        child: Icon(Icons.add, color: Colors.white,),
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomNavigationBarHome(),
    );
  }
}