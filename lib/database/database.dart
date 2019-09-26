// Open the database and store the reference.
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _dbName = 'langfella.db';
  static final _dbVersion = 4;
  static const String wordTable = 'words';
  static final String bookTable = 'books';

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database _database;

  //singleton design pattern syntax in dart
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  /// open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(_createTables);
  }

  /// SQL string to run on creating db
  final String _createTables = '''
   
      CREATE TABLE books(
        id INTEGER PRIMARY KEY,
        title TEXT,
        author TEXT,
        level TEXT,
        level_letter TEXT,
        story_line TEXT,
        genre TEXT,
        unique_words INTEGER,
        total_words INTEGER,
        chapters TEXT,
        hardwords TEXT,
        curr_chapter_index INTEGER 
      );
      
      CREATE TABLE words (
        id INTEGER PRIMARY KEY, 
        book_id TEXT,
        word TEXT NOT NULL, 
        translation TEXT NOT NULL, 
        source_lang TEXT,
        target_lang TEXT,
        example_sentences TEXT,
        date_saved INTEGER NOT NULL,
        date_last_rev INTEGER,
        rev_period_count INTEGER NOT NULL,
        word_curr_state INTEGER NOT NULL,
        is_archived INTEGER NOT NULL    
        );
        
        
    ''';
}

getDatabase() async {
  return await DatabaseHelper.instance.database;
}


