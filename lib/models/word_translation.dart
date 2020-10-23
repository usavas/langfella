class WordTranslation {
  int id;
  int bookId;
  String word;
  String translation;
  List<dynamic> exampleSentences;

  String sourceLang;
  String targetLang;

  DateTime dateSaved;
  DateTime dateLastRevision;
  int revPeriodCount;

  WordCurrentState wordCurrentState;

  bool isArchived;

  WordTranslation(
    this.word,
    this.translation,
    this.sourceLang,
    this.targetLang, {
    this.exampleSentences,
  }) {
    this.dateSaved = DateTime.now();
    this.revPeriodCount = 0;
    this.wordCurrentState = WordCurrentState.LEARNING;
    this.isArchived = false;
  }

  WordTranslation.fromJSON(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'],
        word = jsonMap['word'],
        translation = jsonMap['translation'],
        exampleSentences = jsonMap['exampleSentences'],
        sourceLang = jsonMap['sourceLang'],
        targetLang = jsonMap['targetLang'],
        dateSaved = jsonMap['dateSaved'],
        dateLastRevision = jsonMap['dateLastRevision'],
        revPeriodCount = jsonMap['revPeriodCount'],
        wordCurrentState = jsonMap['wordCurrentState'],
        isArchived = jsonMap['isArchived'],
        bookId = jsonMap['readingId'];

  Map<String, dynamic> toDbMap() => {
        "id": id,
        "book_id": bookId,
        "word": word,
        'translation': translation,
        'source_lang': sourceLang,
        'target_lang': targetLang,
        'example_sentences': (exampleSentences != null)
            ? exampleSentences.join(sentenceDelimiter)
            : null,
        'date_saved': dateSaved.millisecondsSinceEpoch,
        'date_last_rev': (dateLastRevision != null)
            ? dateLastRevision.millisecondsSinceEpoch
            : null,
        'rev_period_count': revPeriodCount,
        'word_curr_state':
            (wordCurrentState == WordCurrentState.LEARNING) ? 1 : 2,
        'is_archived': isArchived ? 1 : 0,
      };

  factory WordTranslation.fromDbMap(Map<String, dynamic> json) {
    WordTranslation t = WordTranslation(
      json['word'],
      json['translation'],
      json['sourceLang'],
      json['targetLang'],
    );
    t.isArchived = (json['is_archived'] == 1) ? true : false;
    t.wordCurrentState = (json['word_curr_state'] == 1)
        ? WordCurrentState.LEARNING
        : WordCurrentState.MASTERED;
    t.revPeriodCount = json['rev_period_count'];

    t.bookId = json['book_id'];
    t.id = json['id'];

    var dSaved = json['date_saved'];
    if (dSaved != null && dSaved != 0) {
      t.dateSaved = DateTime.fromMillisecondsSinceEpoch(dSaved);
    }
    var dLastRev = json['date_last_rev'];
    if (dLastRev != null && dLastRev != 0) {
      t.dateLastRevision = DateTime.fromMillisecondsSinceEpoch(dLastRev);
    }

    t.exampleSentences = (json['example_sentences'] != null)
        ? json['example_sentences'].split(sentenceDelimiter)
        : null;

    return t;
  }
}

enum WordCurrentState { LEARNING, MASTERED }
const String sentenceDelimiter = '##';
