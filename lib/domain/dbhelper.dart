import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();
  static DBHelper getinstance() => DBHelper._();

  Database? mDB;

  static final String TABLE_NOTE_NAME = "note";
  static final String COLUMN_NOTE_ID = "note_id";
  static final String COLUMN_NOTE_TITLE = "note_title";
  static final String COLUMN_NOTE_DESC = "note_desc";

  Future<Database> getDB() async {
    if (mDB != null) {
      return mDB!;
    } else {
      mDB = await openDB();
      return mDB!;
    }
  }

  Future<Database> openDB() async {
    var appDir = await getApplicationDocumentsDirectory();
    var dbpath = join(appDir.path, "notes.db");

    return openDatabase(
      dbpath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            "Create table $TABLE_NOTE_NAME($COLUMN_NOTE_ID integer primary key autoincrement,  $COLUMN_NOTE_TITLE text, $COLUMN_NOTE_DESC text)");
      },
    );
  }

  Future<bool> addNote({
    required String title,
    required String desc,
  }) async {
    Database db = await getDB();
    int rowsEffected = await db.insert(TABLE_NOTE_NAME, {
      COLUMN_NOTE_TITLE: title,
      COLUMN_NOTE_DESC: desc,
    });
    return rowsEffected > 0;
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    var db = await getDB();
    List<Map<String, dynamic>> mData = await db.query(TABLE_NOTE_NAME);
    return mData;
  }
}
