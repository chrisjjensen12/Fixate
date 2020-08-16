import 'package:fixate/home_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pages.dart';
import 'home_view.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeView(),
    ToDo(),
    Calendar(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Week",
          style: Theme.of(context).textTheme.headline4,
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: _children[_currentIndex], //build method for whatever tab eg home, to do, calendar
      bottomNavigationBar: CupertinoTabBar(
        activeColor: Colors.black,
        backgroundColor: Colors.white,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home, size: 25),
            title: Text("Home"),
          ),
          
          BottomNavigationBarItem(
            icon: new Icon(Icons.check_circle_outline, size: 25),
            title: Text("To Do"),
          ),

          BottomNavigationBarItem(
            icon: new Icon(Icons.calendar_today, size: 25),
            title: Text("Calendar"),
          ),
        ]
      ),
    );
  }

  void onTabTapped(int index){
    setState(() {
      _currentIndex = index;
    });
  }
}

