import 'package:flutter/material.dart';
import 'home_card_values.dart';
import 'tasks_view.dart';
import 'package:fixate/utils/database_helper.dart';
import 'dart:async';

class HomeView extends StatefulWidget {
  // final Note note;
  // HomeView(this.note);
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // final Note note;
  // _HomeViewState(this.note);
  DatabaseHelper databaseHelper = DatabaseHelper();
  final List<HomeCardValues> daysList = [
    //you can add numerical values to this, look at 1manstartup listview cards
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
    final homeCardValue = daysList[index];
    getTasks().then((int result) {
      daysList[0].numTasks = result;
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
                                homeCardValue.numTasks.toString(),
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
                                taskOrTasks(daysList[0].numTasks),
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

  Future<int> getTasks() async {
    int numTasks = await databaseHelper.getCount();
    return numTasks;
  }

  String taskOrTasks(int numTasks) {
    if (numTasks == 1) {
      return "Task";
    } else {
      return "Tasks";
    }
  }

  int indexDayOfWeek(String weekday) {
    switch (weekday) {
      case "Monday":
        return 0;
        break;
      case "Tuesday":
        return 1;
        break;
      case "Wednesday":
        return 2;
        break;
      case "Thursday":
        return 3;
        break;
      case "Friday":
        return 4;
        break;
      case "Saturday":
        return 5;
        break;
      case "Sunday":
        return 6;
        break;
      default:
        debugPrint("Switch case error");
        return null;
        break;
    }
  }
}
