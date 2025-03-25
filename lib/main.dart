import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/model.dart';
import 'home_page.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
        create: (context) => NoteProvider(),
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Sora',
        scaffoldBackgroundColor: Colors.grey[50],
        checkboxTheme: CheckboxThemeData(
          visualDensity: VisualDensity.compact,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Color(0xff675dfe),
          selectionColor: Color(0xff675dfe),
          selectionHandleColor: Color(0xff675dfe)
        ),
        appBarTheme: AppBarTheme(
          color: Colors.grey[50],
          scrolledUnderElevation: 0,
        ),
      ),
      home: HomePage(),
    );
  }
}

