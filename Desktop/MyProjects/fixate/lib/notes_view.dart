import 'package:flutter/material.dart';
import 'notes_details_view.dart';
import 'package:fixate/models/note.dart';
import 'package:fixate/utils/database_helper.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

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
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(Icons.arrow_forward, color: Colors.white),
            ),
            title: Text(this.noteList[position].title),
            subtitle: Text(this.noteList[position].dateAndTime),
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
              navigateToNoteDetail(this.noteList[position], 'Edit Note');
            },
          ),
        );
      },
    );
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
      debugPrint("Note deleted successfully");
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
