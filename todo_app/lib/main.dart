import 'package:flutter/material.dart';
import 'package:todo_app/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
               theme: ThemeData(
       
        scaffoldBackgroundColor: Colors.white, 
        appBarTheme: AppBarTheme(
          color: Color.fromARGB(255, 4, 21, 77), 
        ),
      ),


      home: const HomeScreen(),
    );
  }
}

