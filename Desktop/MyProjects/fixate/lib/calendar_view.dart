import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;

// import 'package:fixate/utils/database_helper.dart';
// import 'package:fixate/models/note.dart';

class CalendarView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(color: new Color(0xF8F8F8), child: dateWidget());
  }
}

Widget dateWidget() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: CalendarCarousel(
      weekendTextStyle: TextStyle(
        color: Colors.black,
      ),
      weekdayTextStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      headerTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 19,
        fontWeight: FontWeight.bold,
      ),
      thisMonthDayBorderColor: Colors.black,
      iconColor: Colors.black,
      prevMonthDayBorderColor: Colors.black,
      nextMonthDayBorderColor: Colors.black,
      selectedDayBorderColor: Colors.black,
      selectedDayButtonColor: Colors.black,
      customDayBuilder: (
        /// you can provide your own build function to make custom day containers
        bool isSelectable,
        int index,
        bool isSelectedDay,
        bool isToday,
        bool isPrevMonthDay,
        TextStyle textStyle,
        bool isNextMonthDay,
        bool isThisMonthDay,
        DateTime day,
      ) {
        /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
        /// This way you can build custom containers for specific days only, leaving rest as default.

        // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
        return null;
      },
      weekFormat: false,
      // markedDatesMap: _markedDateMap,
      height: 420.0,
      selectedDateTime: DateTime.now(),
      daysHaveCircularBorder: false,

      /// null for not rendering any border, true for circular border, false for rectangular border
    ),
  );
}
