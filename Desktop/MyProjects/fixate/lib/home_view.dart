import 'package:flutter/material.dart';
import 'home_card_values.dart';
import 'tasks_view.dart';
import 'package:fixate/utils/database_helper.dart';
import 'dart:async';

class HomeView extends StatefulWidget {
  @override
  // final Note note;
  // HomeView(this.note);
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // final Note note;
  // _HomeViewState(this.note);
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<HomeCardValues> daysList = [
    HomeCardValues("Monday", 0),
    HomeCardValues("Tuesday", 0),
    HomeCardValues("Wednesday", 0),
    HomeCardValues("Thursday", 0),
    HomeCardValues("Friday", 0),
    HomeCardValues("Saturday", 0),
    HomeCardValues("Sunday", 0),
  ];

  Widget build(BuildContext context) {
    return Container(
      color: new Color(0xF8F8F8),
      child: new ListView.builder(
          itemCount: daysList.length,
          itemBuilder: (BuildContext context, int index) =>
              buildDaysCard(context, index)),
    );
  }

  Widget buildDaysCard(BuildContext context, int index) {
    // for (var i = 0; i <= 6; i++) {
    // getTasks(indexDayOfWeek(i)).then((int result) {
    //   daysList[i].numTasks = result;
    //   setState(() {});
    // });
    //   // print(i);
    // }
    HomeCardValues homeCardValue = daysList[index];
    getTasks(homeCardValue.day).then((int result) {
      homeCardValue.numTasks = result;
      setState(() {});
    });
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
                                  homeCardValue.day,
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
                                    // print(homeCardValue.day);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return TasksView(homeCardValue.day);
                                      }),
                                    );
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
                                homeCardValue.numTasks
                                    .toString(), //display number of tasks here
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
                                taskOrTasks(homeCardValue.numTasks),
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

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  Future<int> getTasks(String weekday) async {
    int numTasks = await databaseHelper.getCountWeekday(weekday);
    if (numTasks >= 100) {
      _showAlertDialog("Status", 'Max Number Reached, tasks will stay at 99.');
      return 99;
    }
    return numTasks;
  }

  String taskOrTasks(int numTasks) {
    if (numTasks == 1) {
      return "Task";
    } else {
      return "Tasks";
    }
  }

  String indexDayOfWeek(int weekday) {
    switch (weekday) {
      case 0:
        return "Monday";
        break;
      case 1:
        return "Tuesday";
        break;
      case 2:
        return "Wednesday";
        break;
      case 3:
        return "Thursday";
        break;
      case 4:
        return "Friday";
        break;
      case 5:
        return "Saturday";
        break;
      case 6:
        return "Sunday";
        break;
      default:
        debugPrint("Switch case error");
        return null;
        break;
    }
  }
}
