import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import '../model/item.dart';



class NewsApiDb{
  Database db;

 void init() async {
    
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path,"items.db");
    db = await openDatabase(path,
      version: 1,
      onCreate: (Database newDb,int version){

      newDb.execute(
        """
        CREATE TABLE Items
        (
        
        id INTEGER PRIMARY_KEY,
        type TEXT,
        by TEXT,
        time INTEGER,
        text TEXT,
        parent INTEGER,
        kids BLOB,
        dead INTEGER,
        deleted INTEGER,
        url TEXT,
        score INTEGER,
        title TEXT,
        descendants INTEGER
        
        )
        

""");

      }

    );

  }
 Future<itemModel> fetchItems(int id) async{
  final maps = await  db.query(
      "Items",
      columns: null,
      where:"id = ?",
      whereArgs: [id],

    );
  if(maps.length > 0){
    return itemModel.fromDb(maps.first);

  }
  return null;

  }

 Future<int> addItem(itemModel item){
  return   db.insert("Items", item.toMapForDb());

  }

}
