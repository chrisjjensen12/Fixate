import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class TasksDetailsView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return TasksDetailsViewState();
  }
}

class TasksDetailsViewState extends State<TasksDetailsView> {

  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();

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
              padding: EdgeInsets.only(top:15, bottom:15),
              child: TextField(
                controller: titleController,
                onChanged: (value){
                  debugPrint("text field");
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                  labelText: "Title",
                ),
              )
            ),
            //notes
            Padding(
              padding: EdgeInsets.only(top:15, bottom:15),
              child: TextField(
                controller: notesController,
                onChanged: (value){
                  debugPrint("text field");
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                  labelText: "Notes",
                ),
              )
            ),
            //row of buttons
            Padding(
              padding: EdgeInsets.only(top:15, bottom:15),
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