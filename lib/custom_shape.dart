import 'package:flutter/material.dart';

class CustomNavigationBarHome extends StatelessWidget{
  const CustomNavigationBarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 70,
      color: Colors.white,
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(icon: ImageIcon(AssetImage('icons/task-checklist.png'),), onPressed: () {}),
          SizedBox(width: 40), // Space for FAB
          IconButton(icon: ImageIcon(AssetImage('icons/user.png'), color: Colors.black26,), onPressed: () {}),
        ],
      ),
    );
  }
}

class CustomNavigationBarNote extends StatelessWidget{
  const CustomNavigationBarNote({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 60,
      color: Colors.white,
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(icon: Icon(Icons.add_box_outlined), onPressed: () {}),
          SizedBox(width: 10), // Space for FAB
          IconButton(icon: Icon(Icons.color_lens_outlined), onPressed: () {}),
          SizedBox(width: 10), // Space for FAB
          IconButton(icon: Icon(Icons.format_color_text), onPressed: () {}),
        ],
      ),
    );
  }
}