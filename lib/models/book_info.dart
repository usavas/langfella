class BookInfo {
  int id;
  String title;
  String author;
  String level;
  String levelLetter;
  String storyLine;
  String genre;
  int uniqueWords;
  int totalWords;
  String excerpt;
  List<dynamic> hardwords;

  BookInfo(
      {this.title,
      this.author,
      this.level,
      this.levelLetter,
      this.storyLine,
      this.genre,
      this.uniqueWords,
      this.totalWords,
      this.excerpt,
      this.hardwords});

  String getBookTitle(){
    return
      this.title.toLowerCase().split(" ").join("-")
          + "-"
          + this.author.toLowerCase().split(" ").join("-");
  }

  BookInfo.fromJSON(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'],
        title = jsonMap['title'],
        author = jsonMap['author'],
        level = jsonMap['level'],
        levelLetter = jsonMap['levelLetter'],
        storyLine = jsonMap['storyLine'],
        genre = jsonMap['genre'],
        uniqueWords = jsonMap['uniqueWords'],
        totalWords = jsonMap['totalWords'],
        excerpt = jsonMap['excerpt'],
        hardwords = jsonMap['hardwords'];
}
