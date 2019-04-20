class BookModel {
  final String bookId;
  final String bookname;
  final String price;
  final String author;
  final String category;
  final String langauge;
  final String isbn;
  final String publish;

  BookModel(this.bookId, this.bookname, this.price, this.author, this.category,
      this.langauge, this.isbn, this.publish);
  static BookModel fromJson(Map<String, dynamic> data) {
    return BookModel(
        data['id'],
        data['name'],
        data['price'],
        data['author'],
        data['category'],
        data['language'],
        data['ISBN'],
        data['publish_date']);
  }

  static List<BookModel> listFromJson(var data) {
    List<BookModel> books = [];
    for (var bookItem in data) {
      books.add(BookModel.fromJson(bookItem));
    }
    return books;
  }
}
