import 'package:flutter/material.dart';
import 'package:fixate/models/note.dart';
import 'package:fixate/utils/database_helper.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class ToDo extends StatefulWidget {
  @override
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    String weekday = DateFormat('EEEE').format(today);

    if (noteList == null) {
      noteList = List<Note>();
      updateListView(weekday);
    }

    // debugPrint(weekday);
    return Scaffold(
      body: getTasksListView(weekday),
    );
  }

  ListView getTasksListView(String weekday) {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              title: Text(this.noteList[position].title),
              subtitle: Text(
                  "${this.noteList[position].dateAndTime}-${this.noteList[position].dateAndTimeTo}"),
            ));
      },
    );
  }

  // void navigateToDetail(Note note, String title) async {
  //   // bool result =
  //   //     await Navigator.push(context, MaterialPageRoute(builder: (context) {
  //   //   return TasksDetailsView(note, title);
  //   // }));

  //   if (result == true) {
  //     updateListView(title);
  //   }
  // }

  void updateListView(String appBarTitle) {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture =
          databaseHelper.getNoteList(appBarTitle);
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
