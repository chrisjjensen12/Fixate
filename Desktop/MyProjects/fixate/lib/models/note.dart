class Note {
  int _id;
  String _title;
  String _dateAndTime;
  String _location;
  String _day;
  String _notes;
  String _dateAndTimeTo;
  // String _dateAdded;

  Note(this._title, this._dateAndTime, this._location, this._day,
      [this._dateAndTimeTo, this._notes]);

  Note.withId(
      this._id, this._title, this._dateAndTime, this._location, this._day,
      [this._dateAndTimeTo, this._notes]);

  // this._dateAdded,

  int get id => _id;
  String get title => _title;
  String get dateAndTime => _dateAndTime;
  String get notes => _notes;
  String get location => _location;
  String get day => _day;
  String get dateAndTimeTo => _dateAndTimeTo;
  // String get dateAdded => _dateAdded;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set dateAndTime(String newDateAndTime) {
    this._dateAndTime = newDateAndTime;
  }

  set location(String newLocation) {
    if (newLocation.length <= 255) {
      this._location = newLocation;
    }
  }

  set notes(String newNotes) {
    if (newNotes.length <= 255) {
      this._notes = newNotes;
    }
  }

  set day(String newDay) {
    if (newDay.length <= 255) {
      this._day = newDay;
    }
  }

  set dateAndTimeTo(String newDateAndTimeTo) {
    this._dateAndTimeTo = newDateAndTimeTo;
  }

  // set dateAdded(String newDateAdded) {
  //   this._dateAdded = newDateAdded;
  // }

  //converting a note object into a map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['dateAndTime'] = _dateAndTime;
    map['location'] = _location;
    map['notes'] = _notes;
    map['day'] = _day;
    map['dateAndTimeTo'] = _dateAndTimeTo;
    // map['dateAdded'] = _dateAdded;

    return map;
  }

  //extract note object from map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._dateAndTime = map['dateAndTime'];
    this._location = map['location'];
    this._notes = map['notes'];
    this._day = map['day'];
    this._dateAndTimeTo = map['dateAndTimeTo'];
    // this._dateAdded = map['dateAdded'];
  }
}
