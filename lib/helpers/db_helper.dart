import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class sqlDatabase {

  static Future<Database> initDatabase() async{
    final databasePath =  await sql.getDatabasesPath();
  return  sql.openDatabase(path.join(databasePath,'onsite-tracking'),onCreate: (database, version) {
    return database.execute('CREATE TABLE users(id Text PRIMARY KEY , name Text , email Text, first_time TEXT, idofuser Text)');
  },version: 1);



  }

  static Future<void> insertdata(String tablename, Map <String,dynamic> data) async{

  Database sql = await sqlDatabase.initDatabase();
  sql.insert('users', data,conflictAlgorithm: ConflictAlgorithm.replace);
print('done');

  }

  static Future <String> getUsername() async{

    Database sql =  await sqlDatabase.initDatabase();
    final Databasebody = await sql.query('users');
    return Databasebody[0]['name'];


  }

  static Future <String> getUserId() async{

    Database sql =  await sqlDatabase.initDatabase();
    final Databasebody = await sql.query('users');
    return Databasebody[0]['idofuser'];


  }



}