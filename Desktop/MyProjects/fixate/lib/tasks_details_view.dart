import 'package:flutter/material.dart';
import 'date_picker_view.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class TasksDetailsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TasksDetailsViewState();
  }
}

class TasksDetailsViewState extends State<TasksDetailsView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  DateTime _dateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("New Task"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15, left: 10, right: 10),
        child: ListView(
          children: <Widget>[
            //title
            Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: TextField(
                  maxLines: 1,
                  maxLength: 35,
                  maxLengthEnforced: true,
                  controller: titleController,
                  onChanged: (value) {
                    debugPrint("text field");
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    labelText: "Title",
                  ),
                )),
            //date time picker
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 5),
              child: CupertinoButton(
                color: Colors.black,
                child: Text(
                    _dateTime == null ? 'Date and Time' : _dateTime.toString(),
                    style: new TextStyle(color: Colors.white)),
                onPressed: () {
                  // print(homeCardValue.day);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return DatePickerView();
                    }),
                  );
                },
              ),
            ),
            //location
            Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: TextField(
                  maxLines: 1,
                  maxLength: 35,
                  maxLengthEnforced: true,
                  controller: locationController,
                  onChanged: (value) {
                    debugPrint("text field");
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
                    debugPrint("text field");
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
                  Expanded(
                    child: RaisedButton(
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text("Save"),
                      onPressed: () {
                        setState(() {
                          debugPrint("Save clicked");
                        });
                      },
                    ),
                  ),
                  Container(width: 5.0),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.black,
                      textColor: Colors.white,
                      child: Text("Delete"),
                      onPressed: () {
                        setState(() {
                          debugPrint("Delete clicked");
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
    );
  }
}
