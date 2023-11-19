class Quotes {
  int id = 0;
  String quote;
  String author;
  String category;

  Quotes(this.quote, this.author, this.category, {this.id = 0});

  factory Quotes.fromMap({required Map data}) {
    return Quotes(
      data['quote'],
      data['author'],
      data['category'],
    );
  }

  factory Quotes.fromSqlTable({required Map data}) {
    return Quotes(
      data['quote'],
      data['author'],
      data['category'],
      id: data['Id'],
    );
  }

  Map<String, dynamic> get toMap {
    return {
      'quote': quote,
      'author': author,
      'category': category,
    };
  }
}
