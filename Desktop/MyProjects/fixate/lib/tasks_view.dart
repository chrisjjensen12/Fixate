import 'package:flutter/material.dart';
import 'tasks_details_view.dart';
import 'package:fixate/models/note.dart';
import 'package:fixate/utils/database_helper.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'details_view.dart';

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
      updateListView(appBarTitle);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        // leading: new IconButton(
        //   icon: new Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pop(context, true);
        //   },
        // ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            splashColor: Colors.white,
            highlightColor: Colors.white,
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
                    ''
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
        return Slidable(
          actionPane: SlidableStrechActionPane(),
          actionExtentRatio: 0.25,
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Edit',
              color: Colors.black,
              icon: Icons.edit,
              onTap: () => navigateToDetail(
                  this.noteList[position], 'Edit Task: $appBarTitle'),
            ),
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () => _delete(context, this.noteList[position]),
            ),
          ],
          child: Card(
            color: Colors.white,
            elevation: 2,
            child: ListTile(
              trailing: Text(timeString(this.noteList[position])),
              leading: GestureDetector(
                onTap: () {
                  //navigate to details page
                  navigateToDetailsPage(this.noteList[position]);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ),
              title: Text(this.noteList[position].title),
              subtitle: Text(this.noteList[position].location),
            ),
          ),
        );
      },
    );
  }

  String timeString(Note note) {
    // debugPrint("dateAndTime: ${note.dateAndTime}");
    // debugPrint("dateAndTimeTo: ${note.dateAndTimeTo}");
    if (note.dateAndTime == '' && note.dateAndTimeTo == '') {
      return "No Time Selected";
    }
    if (note.dateAndTime == '' && note.dateAndTimeTo != '') {
      return "End Time: ${note.dateAndTimeTo}";
    }
    if (note.dateAndTime != '' && note.dateAndTimeTo == '') {
      return "Start Time: ${note.dateAndTime}";
    }
    if (note.dateAndTime != '' && note.dateAndTimeTo != '') {
      return "${note.dateAndTime} - ${note.dateAndTimeTo}";
    }
    return "null";
  }

  void navigateToDetail(Note note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TasksDetailsView(note, title);
    }));

    if (result == true) {
      updateListView(appBarTitle);
    }
  }

  void navigateToDetailsPage(Note note) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DetailsView(note);
    }));
  }

  void _delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      // debugPrint("Note deleted successfully");
      updateListView(appBarTitle);
    }
  }

  // void _showSnackBar(BuildContext context, String message) {
  //   final snackBar = SnackBar(content: Text(message));
  //   Scaffold.of(context).showSnackBar(snackBar);
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
