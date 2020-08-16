import 'package:flutter/material.dart';
import 'home_widget.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
 @override 
 Widget build(BuildContext context){
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     title: "Fixate",
     theme: ThemeData(
       primarySwatch: Colors.grey,
       fontFamily: 'Cupertino',
       textTheme: TextTheme(
         headline1: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold, color: Colors.black),
         headline2: TextStyle(fontSize: 57.0, fontWeight: FontWeight.bold, color: Colors.black),
         headline3: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black),
         headline4: TextStyle(fontSize: 33.0, fontWeight: FontWeight.bold, color: Colors.black),
       ),
     ),
     home: Home(),
   );
 }
}

