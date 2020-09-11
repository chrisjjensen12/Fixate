//note_detail.dart
import 'package:flutter/material.dart';
import 'date_picker_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:fixate/models/note.dart';
import 'package:fixate/utils/database_helper.dart';

// import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

// ignore: must_be_immutable
class TasksDetailsView extends StatefulWidget {
  final String appBarTitle;
  final Note note;
  TasksDetailsView(this.note, this.appBarTitle);

  State<StatefulWidget> createState() {
    return TasksDetailsViewState(this.note, this.appBarTitle);
  }
}

class TasksDetailsViewState extends State<TasksDetailsView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  DateTime _dateTime;
  String appBarTitle;
  Note note;
  DatabaseHelper helper = DatabaseHelper();
  TasksDetailsViewState(this.note, this.appBarTitle);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    titleController.text = note.title;
    notesController.text = note.notes;
    locationController.text = note.location;

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(appBarTitle),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15, left: 10, right: 10),
          child: ListView(
            children: <Widget>[
              //title
              Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 5),
                  child: TextFormField(
                    maxLines: 1,
                    maxLength: 35,
                    maxLengthEnforced: true,
                    controller: titleController,
                    onChanged: (value) {
                      note.title = titleController.text;
                      debugPrint("title field");
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      labelText: "Title",
                    ),
                  )),
              // date time picker
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: CupertinoButton(
                  color: Colors.black,
                  child: Text(
                      _dateTime == null
                          ? 'Select Time'
                          : DateFormat(
                                  'h:mm aaa') //fix to make it just select time and not date
                              .format(_dateTime),
                      style: new TextStyle(color: Colors.white)),
                  onPressed: () {
                    navigateToDatePicker(context).then((DateTime result) {
                      _dateTime = result;
                      note.dateAndTime =
                          DateFormat('h:mm aaa').format(_dateTime);
                      setState(() {});
                    });
                  },
                ),
              ),
              //location
              Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 5),
                  child: TextFormField(
                    maxLines: 1,
                    maxLength: 35,
                    maxLengthEnforced: true,
                    controller: locationController,
                    onChanged: (value) {
                      note.location = locationController.text;
                      debugPrint("location field");
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter a location';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      labelText: "Location",
                    ),
                  )),
              //notes
              Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: TextField(
                    maxLines: 3,
                    maxLengthEnforced: false,
                    controller: notesController,
                    onChanged: (value) {
                      note.notes = notesController.text;
                      debugPrint("notes field");
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      labelText: "Notes",
                    ),
                  )),
              //row of buttons
              Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Row(
                  children: <Widget>[
                    //save button
                    Expanded(
                      child: CupertinoButton(
                        color: Colors.black,
                        child: Text("Save",
                            style: Theme.of(context).textTheme.headline5),
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState.validate()) {
                              debugPrint(
                                  "Save clicked:\n${note.title}, ${note.day}, ${note.dateAndTime}, ${note.location}, ${note.notes}");
                              _save();
                            }
                          });
                        },
                      ),
                    ),
                    Container(width: 5.0),
                    //delete button
                    Expanded(
                      child: CupertinoButton(
                        color: Colors.black,
                        child: Text(
                          "Delete",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        onPressed: () {
                          setState(() {
                            debugPrint("Delete clicked");
                            _delete();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Save data to database
  void _save() async {
    moveToLastScreen();

    // note.dateAdded = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null) {
      // Case 1: Update operation
      result = await helper.updateNote(note);
    } else {
      // Case 2: Insert Operation
      result = await helper.insertNote(note);
    }

    if (result != 0) {
      // Success
      _showAlertDialog('Status', 'Note Saved Successfully');
    } else {
      // Failure
      _showAlertDialog('Status', 'Problem Saving Note');
    }
  }

  void _delete() async {
    moveToLastScreen();

    // Case 1: If user is trying to delete the NEW NOTE i.e. he has come to
    // the detail page by pressing the FAB of NoteList page.
    if (note.id == null) {
      // debugPrint("note.id = null");
      // _showAlertDialog('Status', 'No Note was deleted');
      debugPrint("No note was deleted");
      return;
    }

    // Case 2: User is trying to delete the old note that already has a valid ID.
    int result = await helper.deleteNote(note.id);
    if (result != 0) {
      // debugPrint("result != 0");
      debugPrint("Note deleted successfully");
    } else {
      // debugPrint("result == 0");
      _showAlertDialog('Status', 'Error Occured while Deleting Note');
    }
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}

Future<DateTime> navigateToDatePicker(BuildContext context) async {
  DateTime result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => DatePickerView()),
  );
  // print(
  //     '${result.month}/${result.day}/${result.year} ${result.hour}:${result.minute}');
  return result;
}

//display date and time
// Padding(
//   padding: EdgeInsets.only(top: 15, bottom: 15),
//   child: Row(
//     children: <Widget>[
//       Expanded(
//         child: CupertinoButton(
//           color: Colors.black,
//           child: Text(
//               _dateTime == null
//                   ? 'Select Date'
//                   : _dateTime.toString(),
//               style: new TextStyle(color: Colors.white)),
//           onPressed: () {
//             navigateToDatePicker(context).then((DateTime result) {
//               // print(
//               //     '${result.month}/${result.day}/${result.year} ${result.hour}:${result.minute}');
//               _dateTime = result;
//               setState(() {});
//             });
//           },
//         ),
//       ),
//       Container(width: 5.0),
//       Expanded(
//         child: CupertinoButton(
//           pressedOpacity: 1,
//           color: Colors.black,
//           child: Text(
//               _dateTime == null ? 'null' : _dateTime.toString(),
//               style: new TextStyle(color: Colors.white)),
//           onPressed: () {
//             debugPrint("nothing happens");
//           },
//         ),
//       ),
//     ],
//   ),
// ),
