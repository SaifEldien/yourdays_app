import 'package:sqflite/sqflite.dart';

import '../models/day.dart';
import '../models/user.dart';
import 'database_functions.dart';

class DataBase {
  static late Database _db;
  static const String _usersTable = "CREATE TABLE Users("
      "email TEXT PRIMARY KEY,"
      "name TEXT,"
      "registerDate TEXT,"
      "image VARBINARY"
      ");";
  static const String _daysTable =  "CREATE TABLE Days("
      "details TEXT,"
      "name TEXT,"
      "date TEXT,"
      "status Text,"
      "lastUpdateDate Text,"
      "mood INTEGER,"
      "userEmail TEXT REFERENCES Users(email) ON DELETE CASCADE"
      ");";
  static const String _highlightsTable =  "CREATE TABLE Highlights("
      "title TEXT,"
      "image VARBINARY,"
      "highlight_id TEXT PRIMARY KEY,"
      "date TEXT REFERENCES Days(date) ON DELETE CASCADE"
      ");";

  static initializeDb() async {
    _db = (await openDatabase('yourDaysDatabase.db', version: 1,
        onCreate: (db, version) async {
          print("Created db");
        }));

    await _db.execute(_usersTable).then((value) async {print("Created table");}).catchError((onError) {
      onError.toString().contains('already exists')? print('table already exists '):
      print( 'error in creating table $onError');
    });

    await _db.execute(_daysTable).then((value) async {print("Created table");}).catchError((onError) {
      onError.toString().contains('already exists')? print('table already exists '):
      print( 'error in creating table $onError');
    });

    await  _db.execute(_highlightsTable).then((value) async {print("Created table");}).catchError((onError) {
      onError.toString().contains('already exists')? print('table already exists '):
      print( 'error in creating table $onError');
    });



  }

  static addToUsers(UserClass user) async => await DatabaseQueries.insertIntoUsers(_db,user);

  static usersDays(String userEmail) async => await DatabaseQueries.retrieveUserDays(_db,userEmail);

  static user(String userEmail) async => await DatabaseQueries.retrieveUser(_db,userEmail);

  static addADay(Day day) async => await DatabaseQueries.insertIntoDays(_db, day);

  static deleteADay(Day day) async => await DatabaseQueries.deleteFromDays(_db, day);

  static updateADay(Day day) async => await DatabaseQueries.updateDay(_db, day);

  static updateUser(UserClass user) async => await DatabaseQueries.updateUser(_db, user);

  static deleteAll(String userEmail) async => await DatabaseQueries.deleteAll(_db, userEmail);


}
