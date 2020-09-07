import 'package:flutter/material.dart';
import 'date_picker_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

// ignore: must_be_immutable
class TasksDetailsView extends StatefulWidget {
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
            // date time picker
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 5),
              child: CupertinoButton(
                color: Colors.black,
                child: Text(
                    _dateTime == null
                        ? 'Date and Time'
                        : DateFormat('EEE MMM d, ' 'h:mm aaa')
                            .format(_dateTime),
                    style: new TextStyle(color: Colors.white)),
                onPressed: () {
                  navigateToDatePicker(context).then((DateTime result) {
                    _dateTime = result;
                    setState(() {});
                  });
                },
              ),
            ),
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
                    child: CupertinoButton(
                      color: Colors.black,
                      child: Text("Save",
                          style: Theme.of(context).textTheme.headline5),
                      onPressed: () {
                        setState(() {
                          debugPrint("Save clicked");
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ),
                  Container(width: 5.0),
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

Future<DateTime> navigateToDatePicker(BuildContext context) async {
  DateTime result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => DatePickerView()),
  );
  // print(
  //     '${result.month}/${result.day}/${result.year} ${result.hour}:${result.minute}');
  return result;
}
