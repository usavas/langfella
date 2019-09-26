import 'package:langfella2/models/word_translation.dart';
import 'package:langfella2/database/database.dart';
import 'package:sqflite/sqflite.dart';

class WordDao {
  Future<List<WordTranslation>> wordsGet() async {
    DatabaseHelper _dbHelper = DatabaseHelper.instance;
    Database _db = await _dbHelper.database;

    final List<Map<String, dynamic>> maps =
        await _db.query(DatabaseHelper.wordTable);

    return List.generate(
        maps.length, (index) => WordTranslation.fromDbMap(maps[index]));
  }

  Future<WordTranslation> wordGet(String word) async {
    DatabaseHelper _dbHelper = DatabaseHelper.instance;
    Database _db = await _dbHelper.database;

    List<Map> _maps = await _db.query(DatabaseHelper.wordTable,
        where: 'word = ?', whereArgs: [word], limit: 1);

    return List.generate(1, (index) => WordTranslation.fromDbMap(_maps[index]))
        .first;
  }

  /// first checks if a word with the same word string exists
  /// if not directly adds the word
  /// if exists then adds the (differing) translation and example sentence and updates the word
  Future<String> wordInsert(WordTranslation word) async {
    Database _db = getDatabase();

    WordTranslation w = await wordGet(word.word);
    if (w == null) {
      await _db.insert(DatabaseHelper.wordTable, word.toDbMap());
      return 'Word added';
    } else {
      w.exampleSentences.add(w.exampleSentences);
      if (w.translation != word.translation) {
        w.translation += ',' + word.translation;
      }
      updateWord(w);
      return 'Kelime guncellendi';
    }
  }

  Future<int> updateWord(WordTranslation word) async {
    Database _db = getDatabase();

    return await _db.update(
      DatabaseHelper.wordTable,
      word.toDbMap(),
      where: "word = ?",
      whereArgs: [word.word],
    );
  }
}
