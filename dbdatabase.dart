import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class dbdatabase
{
    Future<Database> fordatabase()
     async {
       var databasesPath = await getDatabasesPath();
       String path = join(databasesPath, 'demo.db');

       // open the database
       Database database = await openDatabase(path, version: 1,
           onCreate: (Database db, int version) async {
             // When creating the db, create the table
             await db.execute(
                 'create table contectbook(id integer primary key autoincrement ,name Text, number Text)');
           });
        return database;
     }
  Future<void> insertdata(String s ,String ss, Database database11) async {

    String insertqry="insert into contectbook(name,number)values('$s','$ss')";
      int cnt =await database11.rawInsert(insertqry);
       print (cnt);
  }

   Future<List<Map>>viewdata(Database database1111)    async {

      String dataview="select * from contectbook";
    List<Map>list= await  database1111.rawQuery(dataview);
    print("$list");

    return list;
  }

  Future<int> deletedata2(Database database, int dell) async {

      String dd="delete from contectbook where id='$dell'";
      int ll=await  database.rawDelete(dd);
      print("============${ll}");
      return ll;
  }

 Future<int> Updatedata(Database database, String text, String text1, int id) async {

      String up="update contectbook set name='$text',number='$text1' where id='$id'";
      int updat= await database.rawUpdate(up);
      return updat;
  }


}