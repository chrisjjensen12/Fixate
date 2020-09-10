import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DatePickerView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DatePickerViewState();
  }
}

class DatePickerViewState extends State<DatePickerView> {
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Select Time"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                use24hFormat: false,
                initialDateTime: _dateTime,
                onDateTimeChanged: (dateTime) {
                  // print(dateTime);
                  setState(() {
                    _dateTime = dateTime;
                  });
                },
              )),
          CupertinoButton(
            color: Colors.black,
            child: Text('Done', style: new TextStyle(color: Colors.white)),
            onPressed: () {
              // print(
              //     '${_dateTime.month}/${_dateTime.day}/${_dateTime.year} ${_dateTime.hour}:${_dateTime.minute}'); //_dateTime is variable to be popped
              Navigator.pop(context, _dateTime);
            },
          ),
        ],
      ),
    );
  }
}

// showModalBottomSheet<void>(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return CupertinoDatePicker(
//                         mode: CupertinoDatePickerMode.date,
//                         initialDateTime: DateTime.now(),
//                         onDateTimeChanged: (DateTime newDateTime) {
//                           setState(() => newDateTime = _dateTime);
//                         },
//                       );
//                     },
//                   );
