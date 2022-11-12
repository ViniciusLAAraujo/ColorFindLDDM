import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Defining the Strings that represent the columns of the database table
// Using "final" type because this value will not change

final String colorTable = "colorTable";
final String idCol = "idCol";
final String nameCol = "nameCol";
final String hexCol = "hexCol";

/* Here is a example of singleton pattern in Dart, this class don't have to be
*  a instance for initialize, their method are available of any local of code
* when the _instance method is called, so this is a unique class of all code. */

class ColorHelper {
  /* When ContactHelper is called the factory construct an instance, what's
  * the ContactHelper.internal method, that's allow use all other methods of
  * this class */

  static final ColorHelper _instance = ColorHelper.internal();

  factory ColorHelper() => _instance;

  ColorHelper.internal();

  // Database is a type of sqlite API of Dart, and one database inside a
  // variable called _db is created.

  late Database _db;

/* Theses getters and setters are necessarily, not only for protect the
   variable, but also for implement a kind of test or validation to know if
   the database is already created, when this variable is instantiated, it's
   create a new Database */

  // This function don't return instantaneously so have to be a Future object.

  Future<Database> get db async {
    // Now the method to know if the database isn't null

    if (_db != null) {
      return _db; // If isn't null returns a _db registered on Database type
    } else {
      _db = await initDb(); // If null (not created), initiate a new database

      /* The initDb() is a asynchronous function, so have to be a Future object
      * to return */

      return _db;
    }
  }

  // Function to initialize the database

  /* The initDb() is a asynchronous function, so have to be a Future object
  * to return */

  Future<Database> initDb() async {
    // Capturing the path where the database will be stored

    /* The getDatabasesPath have a delay for complete and return the path, so
    * this function have a await word, showing that's variable have to await
    * the getDatabasesPath finish.
    *
    * For use await word, the function have to be async.*/

    final databasesPath = await getDatabasesPath();
    print(databasesPath);
    /* join method converts each element to a String and concatenates the strings.
    * Iterates through elements of this iterable, converts each one to a String
    * by calling Object.toString, and then concatenates the strings, with the
    * separator string interleaved between the elements.*/

    final path = join("databasesPath", "colors.db");

    // Now the path for database is concluded.
    // Opening the database

    /* The openDatabase method, has a path and version as parameter, although,
    * the onCreate has a Database and a version, this requires isn't
    * instantaneous so have to be an async function */

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
          // The SQL command to initiate

          await db.execute(
              "CREATE TABLE $colorTable($idCol INTEGER PRIMARY KEY, $nameCol TEXT, $hexCol TEXT");
        });
  }

  // Saving contact on database

  Future<Color> saveColor(Color color) async {
    Database dbColor = await db;

    // Here the method toMap catch the attributes of table and pass toMap

    color.id = await dbColor.insert(colorTable, color.toMap() as Map<String,Object?>);
    return color;
  }

  // Obtaining contact for database

  Future<Color?> getColor(int id) async {
    Database dbColor = await db;
    List<Map> maps = await dbColor.query(colorTable,
        columns: [idCol, nameCol, hexCol],
        where: "$idCol = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return Color.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Deleting contact inside database

  Future<int> deleteColor(int id) async {
    Database dbColor = await db;
    return await dbColor
        .delete(colorTable, where: "$idCol = ?", whereArgs: [id]);
  }

  Future<int> updateColor(Color color) async {
    Database dbColor = await db;
    return await dbColor.update(colorTable, color.toMap() as Map<String,Object?>,
        where: "$idCol = ?", whereArgs: [color.id]);
  }

  Future<List> getAllColor() async {
    Database dbColor = await db;
    List listMap = await dbColor.rawQuery("SELECT * FROM $colorTable");
    List<Color> listColor = [];
    for (Map m in listMap) {
      listColor.add(Color.fromMap(m));
    }
    return listColor;
  }

  Future<int?> getNumber() async {
    Database dbColor = await db;
    return Sqflite.firstIntValue(
        await dbColor.rawQuery("SELECT COUNT(*) FROM $colorTable"));
  }

  // Closing database

  Future close() async {
    Database dbColor = await db;
    dbColor.close();
  }
}

// Begin of model class Contact

class Color {
  late int id;
  late String name;
  late String hex;

  // Recovering the data from map database to a normal object
  // The name of method "fromMap" is created by user
  // So this is a simple function that's inside contact and receive a Map as parameter

  // Empty constructor

  Color(int id,String name,String hex){
    this.id=id;
    this.name=name;
    this.hex=hex;
  }

  Color.fromMap(Map map) {
    // Putting the columns variables inside class variables

    id = map[idCol];
    name = map[nameCol];
    hex = map[hexCol];
  }

  // Putting the object values inside a map

  Map toMap() {
    Map<String, dynamic> map = {
      nameCol: name,
      hexCol: hex
    };

    // When the object is created, it's don't have an id
    // So the database have to attribute the id
    // If the object isn't null, the id variable is set to idCol

    if (id != null) {
      map[idCol] = id;
    }

    // In the end of all, this function returns a map

    return map;
  }

  // Overriding toString method to show better the information

  @override
  String toString() {
    return "Contact (id: $id, name: $name, hex: $hex)";
  }
}