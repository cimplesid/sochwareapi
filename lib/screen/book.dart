import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sochwareapi/model/book.dart';
import 'package:sochwareapi/screen/addbook.dart';
import 'package:sochwareapi/screen/login.dart';
import 'dart:convert';

import 'detail.dart';

class Book extends StatefulWidget {
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  Future getBooks() async {
    http.Response res = await http.get('http://flutter.sochware.com/api/books');
    setState(() {
      books = BookModel.listFromJson(json.decode(res.body));
    });
  }

  List books = [];
  @override
  void initState() {
    super.initState();
    getBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(MdiIcons.logout),onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Firstpage())),),
        title: Text("Books"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            await getBooks();
          },
          child: ListView.builder(
            itemCount: books.length,
            itemBuilder: (BuildContext context, int index) {
              BookModel book = books[index];
              return Card(
                color: Colors.orangeAccent,
                child: ListTile(
                  trailing: 
                     Icon(Icons.keyboard_arrow_right,size:25),
                  
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => BookDetail(bookId: book.bookId))),
                  isThreeLine: true,
                  title: Text(book.bookname,
                      style: TextStyle(
                          fontSize: 25.0, fontStyle: FontStyle.italic)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(book.author),
                      SizedBox(
                        height: 5,
                      ),
                      Text(book.publish)
                    ],
                  ),
                ),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddBook()));
        },
      ),
    );
  }
}
