import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'notes_details_view.dart';
import 'package:fixate/models/note.dart';
import 'package:fixate/utils/database_helper.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'details_view2.dart';

class NotesView extends StatefulWidget {
  @override
  _NotesViewState createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  int numTasksCounter;
  int count1 = 0;
  List<Note> noteList;
  int count = 0;
  String appBarTitle = "Notes";
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView(appBarTitle);
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.black,
        onPressed: () {
          navigateToNoteDetail(
              Note(
                '',
                '',
                '',
                appBarTitle,
                '',
                '',
              ),
              "New Note");
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.black,
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
              onTap: () =>
                  navigateToNoteDetail(this.noteList[position], 'Edit Note'),
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
            elevation: 2.0,
            child: ListTile(
              leading: GestureDetector(
                onTap: () {
                  //navigate to details page
                  navigateToDetails2Page(this.noteList[position]);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ),
              title: Text(this.noteList[position].title),
              subtitle: Text(this.noteList[position].dateAndTime),
            ),
          ),
        );
      },
    );
  }

  void navigateToDetails2Page(Note note) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DetailsView2(note);
    }));
  }

  void navigateToNoteDetail(Note note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NotesDetailsView(note, title);
    }));

    if (result == true) {
      updateListView(appBarTitle);
    }
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
