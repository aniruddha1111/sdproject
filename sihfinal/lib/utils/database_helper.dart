import 'package:sihfinal/modules/datamanage.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String customTable = 'custom_table';
   String imageTable = 'image_table';

    String id = 'id';
     String id1 = 'id1';
  String image = 'image';
 

  String colId = 'id';
  String colName = 'name';
  String colLname = 'lname';
  String colAge = 'age';
  String colBlood = 'blood';
  String colSex = 'sex';
   String colDate = 'date';
   String colDisease= 'disease';
    String colMedicine='medicine';
  

  DatabaseHelper._createInstane();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstane();
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
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'kl.db';

    var customDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return customDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $customTable($colId INTEGER PRIMARY KEY AUTOINCREMENT , $colName TEXT , $colLname TEXT, $colAge TEXT,$colBlood TEXT, $colSex TEXT,$colDate TEXT,$colDisease TEXT,$colMedicine TEXT)');
         await db.execute(
         'CREATE TABLE $imageTable($id1 INTEGER PRIMARY KEY AUTOINCREMENT , $id TEXT , $image TEXT)');
   


  }

  Future<List<Map<String, dynamic>>> getCustomMapList(String name) async {
 
    Database db = await this.database;
    
    var result = await db.rawQuery(" SELECT * FROM $customTable  WHERE     $colName LIKE '%   $name   %'  OR  $colName   LIKE '%%%%$name%%%%' OR $colDate LIKE '%%%%$name%%%%' OR $colId = '$name'  COLLATE NOCASE  ");

  return result;
  }
  Future<List<Map<String, dynamic>>> getdiseaseMapList(String name) async {

    Database db = await this.database;

    var result = await db.rawQuery(" SELECT * FROM $customTable  WHERE     $colDisease LIKE '%   $name   %'  OR  $colDisease   LIKE '%%%%$name%%%%'  COLLATE NOCASE  ");

    return result;
  }

  
  Future<List<Map<String, dynamic>>> getCustomMapList1(String name) async {
 
    Database db = await this.database;
    
    var result = await db.rawQuery(" SELECT * FROM $customTable  WHERE $colId = '$name'  COLLATE NOCASE  ");

  return result;
  }

 Future<List<Map<String, dynamic>>> getImageMapList(String name) async {
 
    Database db = await this.database;
    
    var result = await db.rawQuery(" SELECT * FROM $imageTable  WHERE     $id = $name   ");

  return result;
  }



  










  Future<int> insertCustom(Data data) async {
    Database db = await this.database;
    var result = await db.insert(customTable, data.toMap());
    return result;
   
  }

   Future<int> insertImage( image) async {
    Database db = await this.database;
    var result = await db.insert(imageTable, image.toMap());
    return result;
   
   
  }





  

  Future<int> updateCustom(Data data) async {
    Database db = await this.database;
    var result = await db.update(customTable, data.toMap(),
        where: '$colId = ?', whereArgs: [data.id]);
    return result;
  }

   Future<int> updateImage(Image1 image) async {
    Database db = await this.database;
    var result = await db.update(customTable, image.toMap(),
        where: '$id1 = ?', whereArgs: [image.id1]);
    return result;
  }






  Future<int> deleteCustom(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $customTable WHERE $colId = $id');
    return result;
    
  }

  Future<int> deleteImage(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $imageTable WHERE $id1 = $id');
    return result;
    
  }

   Future<List<Map<String, dynamic>>> fetchCustom( iid , iid1) async {
  
    Database db = await this.database;
    
    var result =
        await db.rawQuery("SELECT $colId FROM $customTable WHERE  $colName = '$iid' AND  $colLname = '$iid1'   " );

    return result;
    
  }

 Future<List<Map<String, dynamic>>> fetchImageid( iid ) async {
  
    Database db = await this.database;
    
    var result =
        await db.rawQuery("SELECT * FROM $imageTable WHERE  $id = '$iid'   " );

    return result;
    
  }


 



 

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*)  from $customTable');
    int result = Sqflite.firstIntValue(x);
  return result;

  }

  Future<int> getICount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*)  from $imageTable');
    int result = Sqflite.firstIntValue(x);
  return result;

  }






 Future<List<Data>> getCustomList( name) async {
    var customMapList = await getCustomMapList(name);
    int count = customMapList.length;

    List<Data> customList = List<Data>();

    for (int i = 0; i < count; i++) {
      customList.add(Data.fromMapObject(customMapList[i]));
    }

    return customList;
  }

   Future<List<Data>> getCustomList1( name) async {
    var customMapList = await getCustomMapList1(name);
    int count = customMapList.length;

    List<Data> customList = List<Data>();

    for (int i = 0; i < count; i++) {
      customList.add(Data.fromMapObject(customMapList[i]));
    }

    return customList;
  }
  Future<List<Data>> getdiseaseMaplist( name) async {
    var customMapList = await getCustomMapList1(name);
    int count = customMapList.length;

    List<Data> customList = List<Data>();

    for (int i = 0; i < count; i++) {
      customList.add(Data.fromMapObject(customMapList[i]));
    }

    return customList;
  }

  Future<List<Image1>> getImageList(name) async {
    var imageMapList = await getImageMapList(name);
   
    int count = imageMapList.length;

    List<Image1> imageList = List<Image1>();

    for (int i = 0; i < count; i++) {
      imageList.add(Image1.fromMapObject(imageMapList[i]));
    }

    return imageList;
  }


 

}
