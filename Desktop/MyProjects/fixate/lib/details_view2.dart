import 'package:flutter/material.dart';
import 'package:fixate/models/note.dart';

class DetailsView2 extends StatelessWidget {
  final Note note;
  DetailsView2(this.note);

  Widget build(BuildContext context) {
    if (note.title == null) {
      note.title = "N/A";
    }
    if (note.notes == '') {
      note.notes = "N/A";
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Note Details"),
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
