//note_list.dart
import 'package:flutter/material.dart';
import 'tasks_details_view.dart';
import 'package:fixate/models/note.dart';
import 'package:fixate/utils/database_helper.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

// ignore: must_be_immutable
class TasksView extends StatefulWidget {
  String appBarTitle;
  TasksView(this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return _TasksState(this.appBarTitle);
  }
}

class _TasksState extends State<TasksView> {
  int numTasksCounter;
  int count1 = 0;
  String appBarTitle;
  _TasksState(this.appBarTitle);

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              navigateToDetail(
                  Note(
                    '',
                    '',
                    '',
                    appBarTitle,
                    '',
                  ),
                  "New Task: $appBarTitle");
            },
          )
        ],
      ),
      body: getTasksListView(),
    );
  }

  ListView getTasksListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.black,
              child: Text("hi"),
            ),
            title: Text(this.noteList[position].title),
            subtitle: Text(this.noteList[position].day),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                _delete(context, noteList[position]);
              },
            ),
            onTap: () {
              // debugPrint("ListTile Tapped");
              navigateToDetail(
                  this.noteList[position], 'Edit Task: $appBarTitle');
            },
          ),
        );
      },
    );
  }

  // Widget getTasksView() {
  //   return Container(
  //     color: new Color(0xF8F8F8),
  //     child: new ListView.builder(
  //         itemCount: count1,
  //         itemBuilder: (BuildContext context, int position) =>
  //             buildTaskCard(position)),
  //   );
  // }

  // Widget buildTaskCard(position) {
  //   return new Center(
  //     child: Padding(
  //       padding: const EdgeInsets.all(7.0),
  //       child: Card(
  //         color: Colors.white,
  //         elevation: 4,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         child: Container(
  //             width: 300,
  //             height: 115,
  //             child: Row(
  //               children: <Widget>[
  //                 FittedBox(
  //                   child: Container(
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: <Widget>[
  //                         Padding(
  //                           padding: const EdgeInsets.only(
  //                               top: 12, bottom: 8, left: 17, right: 8),
  //                           child: Row(
  //                             children: <Widget>[
  //                               Text(
  //                                 "hello",
  //                                 style: Theme.of(context).textTheme.headline1,
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                         Padding(
  //                           padding: const EdgeInsets.only(
  //                               top: 7, bottom: 12, left: 13, right: 8),
  //                           child: Row(
  //                             children: <Widget>[
  //                               RawMaterialButton(
  //                                 onPressed: () {
  //                                   navigateToDetail(this.noteList[position],
  //                                       "Edit Task: $appBarTitle");
  //                                 },
  //                                 elevation: 2.0,
  //                                 fillColor: Colors.black,
  //                                 child: Icon(
  //                                   Icons.arrow_forward,
  //                                   size: 20.0,
  //                                   color: Colors.white,
  //                                 ),
  //                                 padding: EdgeInsets.all(12.0),
  //                                 shape: CircleBorder(),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 Spacer(),
  //                 Container(
  //                   child: Column(
  //                     children: <Widget>[
  //                       Padding(
  //                         padding: const EdgeInsets.only(
  //                             top: 8, bottom: 0, left: 8, right: 50),
  //                         child: Row(
  //                           children: <Widget>[
  //                             Text(
  //                               "hi",
  //                               style: Theme.of(context).textTheme.headline2,
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.only(
  //                             top: 0, bottom: 8, left: 8, right: 50),
  //                         child: Row(
  //                           children: <Widget>[
  //                             Text(
  //                               "Tasks",
  //                               style: Theme.of(context).textTheme.headline3,
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             )),
  //       ),
  //     ),
  //   );
  // }

  void navigateToDetail(Note note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TasksDetailsView(note, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void _delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      debugPrint("Note deleted successfully");
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
