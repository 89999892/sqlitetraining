import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlite_addnewcourse/models/coursemodel.dart';
class DbHelper{
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;
  DbHelper.internal();
  static  Database _db;
  Future<Database> Createdatabase()async{
    if(_db != null){
      return _db;
    }else{
      String path=join(await getDatabasesPath(),'school.db');
      _db= await openDatabase(path,version: 1,onCreate: (Database db,int v){
        db.execute("create table courses(id integer primary key autoincrement, name varchar(50), content varchar(255), hours INTEGER)");


      }

      );
      return _db;

    }

   // return _db;

    }
  Future<int>  Creatcourse(courseModel newCourse)async{
    print('create course هناا');
    Database db=await Createdatabase();
    print('create database هناا');
    return db.insert('courses', newCourse.toMap());

    }
  Future<List> allcourses() async{
      Database db= await Createdatabase();
      return db.query('courses');
    }
  Future<int>  deletcourse(int id)async{
    Database db=await Createdatabase();
    return db.delete('courses',where: 'id=?',whereArgs: [id]);
  }
  Future<int>deletAll()async{
    Database db=await Createdatabase();
    return db.delete('courses');
  }
  Future<int>courseUpdate(courseModel course)async{
    Database db=await Createdatabase();
    return await db.update('courses',course.toMap(),where: 'id= ?',whereArgs: [course.id] );
  }





  
}