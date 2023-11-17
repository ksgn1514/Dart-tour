typedef Words = Map<String, String>;

class Dict {
  var words = Words();
  Dict() {}

  void add(Word word) {
    words[word.term] = word.definition;
  }

  String? get(String term) {
    return words[term];
  }

  void delete(String term) {
    words.remove(term);
  }

  void update(String term, String newterm) {
    if (words.containsKey(term)) {
      words[newterm] = words[term]!;
      words.remove(term);
    }
  }

  void showAll() {
    words.forEach((key, value) {
      print('$key: $value');
    });
  }

  int count() {
    return words.length;
  }

  void upsert(Word oldWord, String newterm) {
    if (words.containsKey(oldWord.term)) {
      words[newterm] = words[oldWord.term]!;
      if (oldWord.term != newterm) {
        words.remove(oldWord.term);
      }
    } else {
      add(oldWord);
    }
  }

  bool exists(String term) {
    return words.containsKey(term);
  }

  bulkAdd(List<Word> words) {
    words.forEach((word) {
      add(word);
    });
  }

  bulkDelete(List<String> terms) {
    terms.forEach((term) {
      delete(term);
    });
  }
}

class Word {
  String term;
  String definition;

  Word(this.term, this.definition);
}

void main() {
  var dict = Dict();
  print(dict.words);
  var word = Word('kimchi', '한국의 음식');
  var word1 = Word('sushi', '일본의 음식');
  var word2 = Word('pizza', '이탈리아의 음식');
  var word3 = Word('udon', '일본의 면 음식');
  var word4 = Word('kebab', '터키의 음식');

  //add
  dict.add(word);
  dict.add(word1);
  dict.add(word2);
  dict.add(word3);
  dict.add(word4);
  print(dict.words);

  //get
  print(dict.get('kimchi'));

  //delete
  dict.delete('udon');
  print(dict.words);

  //update
  dict.update('kimchi', '김치');
  print(dict.words);

  //showAll
  dict.showAll();

  //count
  print(dict.count());

  //upsert1
  dict.upsert(word2, '피자');
  print(dict.words);
  //upsert2
  dict.upsert(word3, 'ramen');
  print(dict.words);

  //exists
  print(dict.exists('kimchi'));
  print(dict.exists('김치'));
  print(dict.exists('udon'));

  //bulkAdd
  var words = [Word('ramen', '일본의 면 음식'), Word('pasta', '이탈리아의 면 음식')];
  dict.bulkAdd(words);
  print(dict.words);

  //bulkDelete
  var terms = ['sushi', 'kebab', 'ramen'];
  dict.bulkDelete(terms);
  print(dict.words);
}
