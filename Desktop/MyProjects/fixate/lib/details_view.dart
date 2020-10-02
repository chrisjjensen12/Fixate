import 'package:flutter/material.dart';
import 'package:fixate/models/note.dart';

class DetailsView extends StatelessWidget {
  final Note note;
  DetailsView(this.note);

  Widget build(BuildContext context) {
    if (note.title == null) {
      note.title = "N/A";
    }
    if (note.location == null) {
      note.location = "N/A";
    }
    if (note.dateAndTime == null) {
      note.dateAndTime = "N/A";
    }
    if (note.dateAndTimeTo == null) {
      note.dateAndTimeTo = "N/A";
    }
    if (note.notes == null) {
      note.notes = "N/A";
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Task Details"),
          backgroundColor: Colors.white,
        ),
        body: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0, bottom: 5, left: 0, right: 0),
                  child: RichText(
                    text: TextSpan(
                        text: 'Title: ',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: note.title,
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0, bottom: 5, left: 0, right: 0),
                  child: RichText(
                    text: TextSpan(
                        text: 'Location: ',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: note.location,
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0, bottom: 5, left: 0, right: 0),
                  child: RichText(
                    text: TextSpan(
                        text: 'Start Time: ',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: note.dateAndTime,
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0, bottom: 10, left: 0, right: 0),
                  child: RichText(
                    text: TextSpan(
                        text: 'End Time: ',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: note.dateAndTimeTo,
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        ]),
                  ),
                ),
                Text("Notes:",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(note.notes,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.normal)),
                ),
              ],
            )));
  }
}
