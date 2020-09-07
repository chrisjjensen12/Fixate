class Note {
  int _id;
  String _title;
  DateTime _dateAndTime;
  String _location;
  String _notes;

  Note(this._title, this._dateAndTime, this._location, [this._notes]);

  Note.withId(this._id, this._title, this._dateAndTime, this._location,
      [this._notes]);

  int get id => _id;
  String get title => _title;
  DateTime get dateAndTime => _dateAndTime;
  String get notes => _notes;
  String get location => _location;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set dateAndTime(DateTime newDateAndTime) {
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

    return map;
  }

  //extract note object from map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._dateAndTime = map['dateAndTime'];
    this._location = map['location'];
    this.notes = map['notes'];
  }
}
