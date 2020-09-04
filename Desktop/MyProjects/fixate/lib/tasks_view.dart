import 'package:flutter/material.dart';
import 'tasks_details_view.dart';

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
  int count = 0;
  String appBarTitle;
  _TasksState(this.appBarTitle);

  @override
  Widget build(BuildContext context) {
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return TasksDetailsView();
                }),
              );
            },
          )
        ],
      ),
      body: getTasksView(),
    );
  }

  Widget getTasksView() {
    return Container(
      color: new Color(0xF8F8F8),
      child: new ListView.builder(
          itemCount: count,
          itemBuilder: (BuildContext context, int position) => buildTaskCard()),
    );
  }

  Widget buildTaskCard() {
    return new Center(
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Card(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
              width: 300,
              height: 115,
              child: Row(
                children: <Widget>[
                  FittedBox(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 12, bottom: 8, left: 17, right: 8),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "hello",
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 7, bottom: 12, left: 13, right: 8),
                            child: Row(
                              children: <Widget>[
                                RawMaterialButton(
                                  onPressed: () {
                                    debugPrint("clicked arrow");
                                  },
                                  elevation: 2.0,
                                  fillColor: Colors.black,
                                  child: Icon(
                                    Icons.arrow_forward,
                                    size: 20.0,
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(12.0),
                                  shape: CircleBorder(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 0, left: 8, right: 50),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "hi",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0, bottom: 8, left: 8, right: 50),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Tasks",
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
