
import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper{

  Database ? db;

  // create database
 Future<Database> create_db()async
 {
   if(db == null)
   {
     //db not available - create

     Directory dir = await getApplicationDocumentsDirectory();
     String dbpath = join(dir.path,"taskdb");
     var db = openDatabase(dbpath,version: 1,onCreate: execute);
     return db;
   }
   else
     {
       //db already available

       return db!;
     }
  }

  execute(Database db, int version)
  {

    db.execute("create table newtask (tid integer primary key autoincrement, title text, remark text)");
    log("Table Created");
  }

  Future<int> insertTask(title,remark) async
  {
    //Database Create
    var db = await create_db();
    //insert
    // var id = await db.rawInsert("insert into product (pname,qty,price) values (?,?,?)",[name,qty,price]);

    Map<String,dynamic> params = {
      "title":title,
      "remark":remark
    };
    var id = await db.insert("newtask", params);
    return id;
  }

  Future<List> allTask() async
  {
    var db = await create_db();
    var result = await db.rawQuery("select * from newtask");
    //var result = await db.query("product",columns: ["qty","price"]);
    return result.toList();
  }

  Future<int> deleteTask(tid) async
  {
    var db = await create_db();
    var status = await db.rawDelete("delete from newtask where tid=?",[tid]);
    return status;
  }

  Future<List> getSingleTask(tid) async
  {
    var db = await create_db();
    var result = await db.rawQuery("select * from newtask where tid=?",[tid]);
    return result.toList();
  }

  Future<int> updateTask(title,remark,tid) async
  {
    var db = await create_db();
    var status = await db.rawUpdate("update newtask set title=?,remark=? where tid=?",[title,remark,tid]);
    return status;
  }



}