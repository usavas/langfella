import 'package:langfella2/models/book.dart';
import 'package:langfella2/database/database.dart';
import 'package:sqflite/sqflite.dart';

class BookDao {
  Future<List<Book>> booksGet() async {
    final List<Map<String, dynamic>> maps =
        await getDatabase().query(DatabaseHelper.bookTable);

    return List.generate(maps.length, (index) => Book.fromDbMap(maps[index]));
  }

  Future<List<Book>> booksGetByName(String title) async {
    Database _db = getDatabase();
    final List<Map<String, dynamic>> maps = await _db.query(
      DatabaseHelper.bookTable,
      where: 'title = ?',
      whereArgs: [title]
    );

    return List.generate(maps.length, (index) => Book.fromDbMap(maps[index]));
  }

  Future<Book> bookGetByName(String bookTitle) async {
    List<Map> _maps = await getDatabase().query(DatabaseHelper.bookTable,
        where: 'title = ?', whereArgs: [bookTitle], limit: 1);

    return List.generate(1, (index) => Book.fromDbMap(_maps[index])).first;
  }

  /// checks if a book(s) with the same title exists
  /// if exists then check if the book title author and word count are the same
  /// if same book with same hash exists does nohing
  /// else adds the book to local db
  Future<String> bookInsert(Book book) async {
    Database _db = getDatabase();
    bool existsSameBook = false;

    if (await _bookCountByName(book.title) > 0){
      for (Book b in await booksGetByName(book.title)){
        if(book.getBookHash() == b.getBookHash()){
          existsSameBook = true;
        }
      }
    }

    if (existsSameBook)
      return 'Same book already exists';
    else {
      try {
        await _db.insert(DatabaseHelper.wordTable, book.toDbMap());
        return 'Book added';
      } catch (e) {
        return e.toString();
      }
    }
  }

  Future<int> _bookCountByName(String title) async {
    Database _db = await getDatabase();
    List<Map> maps =
        await _db.rawQuery('SELECT id FROM books WHERE title = ?', [title]);
    return maps.length;
  }

  Future<int> updateBook(Book book) async {
    return await getDatabase().update(
      DatabaseHelper.bookTable,
      book.toDbMap(),
      where: "title = ?",
      whereArgs: [book.title],
    );
  }
}
