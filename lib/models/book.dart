class Book {
  int id;
  String title;
  String author;
  String level;
  String levelLetter;
  String storyLine;
  String genre;
  int uniqueWords;
  int totalWords;
  List<dynamic> chapters;
  List<dynamic> hardwords;

  int currentChapterIndex;

  Book({
    this.id,
    this.title,
    this.author,
    this.level,
    this.levelLetter,
    this.storyLine,
    this.genre,
    this.uniqueWords,
    this.totalWords,
    this.chapters,
    this.hardwords,
    this.currentChapterIndex
  });

  String getImageName(){
    return
      this.title.toLowerCase().split(" ").join("-")
        + "-"
        + this.author.toLowerCase().split(" ").join("-");
  }

  Book.fromJSON(Map<String, dynamic> jsonMap) :
        id = jsonMap['id'],
        title = jsonMap['title'],
        author = jsonMap['author'],
        level = jsonMap['level'],
        levelLetter = jsonMap['levelLetter'],
        storyLine = jsonMap['storyLine'],
        genre = jsonMap['genre'],
        uniqueWords = jsonMap['uniqueWords'],
        totalWords = jsonMap['totalWords'],
        chapters = jsonMap['chapters'],
        hardwords = jsonMap['hardwords'];

  /// helps detect if the same book from book service being added twice
  getBookHash() {
    return title.hashCode + author.hashCode + totalWords.hashCode;
  }


  Map<String, dynamic> toDbMap() => {
    'id': id,
    'title': title,
    'author': author,
    'level': level,
    'level_letter': levelLetter,
    'story_line': storyLine,
    'genre': genre,
    'unique_words': uniqueWords,
    'total_words': totalWords,
    'chapters': (chapters != null) ? chapters.join(dbDelimiter) : null,
    'hardwords' : (hardwords != null) ? hardwords.join(dbDelimiter) : null,
    'currentChapter': (currentChapterIndex != null) ? currentChapterIndex : 0
  };

  factory Book.fromDbMap(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      level: json['level'],
      levelLetter: json['level_letter'],
      storyLine: json['story_line'],
      genre: json['genre'],
      uniqueWords: json['unique_words'],
      totalWords: json['total_words'],
      chapters: json['chapters'],
      hardwords: json['hardwords'],
        currentChapterIndex: json['curr_chapter_index']
    );
  }
}

const String dbDelimiter = '##';












