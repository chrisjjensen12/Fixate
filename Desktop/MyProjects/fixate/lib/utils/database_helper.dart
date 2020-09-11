import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:fixate/models/note.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colNotes = 'notes';
  String colLocation = 'location';
  String colDateAndTime = 'dateAndTime';
  String colDay = 'day';
  // String colDateAdded = 'dateAdded';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    // Open/create the database at a given path
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colNotes TEXT, $colLocation TEXT, $colDateAndTime TEXT, $colDay TEXT)');
  }
  //  $colDateAdded TEXT

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(noteTable);
    return result;
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getMondayList() async {
    Database db = await this.database;
    // String val = "Monday";
//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result =
        await db.rawQuery('SELECT * FROM $noteTable WHERE day= ?', ['Monday']);
    return result;
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getTuesdayList() async {
    Database db = await this.database;
    // String val = "Tuesday";
//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result =
        await db.rawQuery('SELECT * FROM $noteTable WHERE day= ?', ['Tuesday']);
    return result;
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getWednesdayList() async {
    Database db = await this.database;
    // String val = "Wednesday";
//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db
        .rawQuery('SELECT * FROM $noteTable WHERE day= ?', ['Wednesday']);
    return result;
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getThursdayList() async {
    Database db = await this.database;
    // String val = "Thursday";
//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db
        .rawQuery('SELECT * FROM $noteTable WHERE day= ?', ['Thursday']);
    return result;
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getFridayList() async {
    Database db = await this.database;
    // String val = "Friday";
//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result =
        await db.rawQuery('SELECT * FROM $noteTable WHERE day= ?', ['Friday']);
    return result;
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getSaturdayList() async {
    Database db = await this.database;
    // String val = "Saturday";
//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db
        .rawQuery('SELECT * FROM $noteTable WHERE day= ?', ['Saturday']);
    return result;
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getSundayList() async {
    Database db = await this.database;
    // String val = "Sunday";
//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result =
        await db.rawQuery('SELECT * FROM $noteTable WHERE day= ?', ['Sunday']);
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateNote(Note note) async {
    var db = await this.database;
    var result = await db.update(noteTable, note.toMap(),
        where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $noteTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Note>> getNoteList(String weekday) async {
    var noteMapList;
    switch (weekday) {
      case "Monday":
        noteMapList = await getMondayList(); // Get 'Map List' from database
        break;
      case "Tuesday":
        noteMapList = await getTuesdayList(); // Get 'Map List' from database
        break;
      case "Wednesday":
        noteMapList = await getWednesdayList(); // Get 'Map List' from database
        break;
      case "Thursday":
        noteMapList = await getThursdayList(); // Get 'Map List' from database
        break;
      case "Friday":
        noteMapList = await getFridayList(); // Get 'Map List' from database
        break;
      case "Saturday":
        noteMapList = await getSaturdayList(); // Get 'Map List' from database
        break;
      case "Sunday":
        noteMapList = await getSundayList(); // Get 'Map List' from database
        break;
    }

    int count =
        noteMapList.length; // Count the number of map entries in db table
    List<Note> noteList = List<Note>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }
}

// // Get number of Note objects based on WEEKDAY in database
// Future<int> getCountWeekday(String weekday) async {
//   Database db = await this.database;
//   List<Map<String, dynamic>> x =
//       await db.rawQuery('SELECT COUNT (*) from $noteTable');
//   int result = Sqflite.firstIntValue(x);
//   return result;
// }

// // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
// Future<List<Note>> getNoteList() async {
//   var noteMapList = await getNoteMapList(); // Get 'Map List' from database
//   int count =
//       noteMapList.length; // Count the number of map entries in db table

//   List<Note> noteList = List<Note>();
//   // For loop to create a 'Note List' from a 'Map List'
//   for (int i = 0; i < count; i++) {
//     noteList.add(Note.fromMapObject(noteMapList[i]));
//   }

//   return noteList;
// }
