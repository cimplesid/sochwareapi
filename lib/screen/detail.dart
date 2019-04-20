import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sochwareapi/model/book.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sochwareapi/screen/comment.dart';
import 'package:http/http.dart' as http;

class BookDetail extends StatefulWidget {
  // final Map book;

  final String bookId;
  const BookDetail({Key key, this.bookId}) : super(key: key);
  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  BookModel book;
  var _commentcontroller = TextEditingController();

  bool isLoading = true;
  bool iscommentloading = true;

  List comments;
  Future getBook() async {
    http.Response res = await http
        .get('http://flutter.sochware.com/api/bookByID?id=${widget.bookId}');
    setState(() {
      isLoading = false;
    });
    var data = json.decode(res.body);
    if (data["status"] == 200) {
      // get "comment" setState comments

      setState(() {
        book = BookModel.fromJson(data["payload"]);
        comments = data["payload"]["comment"];
      });
    }
  }

  @override
  void initState() {
    
    super.initState();
    getBook();
  }

  @override
  Widget build(BuildContext context) {
    String comment = "";

    return Scaffold(
      appBar: AppBar(
        title: Text(isLoading ? "" : book.bookname),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                        ),
                        Text(
                          book.bookname,
                          style: Theme.of(context).textTheme.display1,
                        ),
                        Text(book.author),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text("Bookname: ${book.bookname}"),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text("Price: Rs ${book.price}"),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text("Category: ${book.category}"),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text("Published on: ${book.publish}"),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text("ISBN : ${book.isbn}"),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text("Langauge : ${book.langauge}"),
                        SizedBox(height: 30),
                        Text('Comments',style: TextStyle(fontSize: 25),),
                        Column(
                            children:comments
                                .map<Widget>((comment) =>
                                    CommentShow(comment["comment"]))
                                .toList()),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6.0,
                        spreadRadius: 9.0)
                  ]),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Row(
                      children: <Widget>[
                        Icon(MdiIcons.commentAccountOutline),
                        VerticalDivider(),
                        Expanded(
                          child: TextField(
                            controller: _commentcontroller,
                            onChanged: (value) {
                              comment = value;
                              
                            },
                            decoration: InputDecoration.collapsed(
                              hintText: 'Comment here',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () async {
                            if (comment.isEmpty)
                              return null;
                            else {
                              Map<String, dynamic> body = {
                                "id": book.bookId,
                                "comment": comment,
                              };
                              print(body);
                              Response response = await post(
                                  'http://flutter.sochware.com/api/comment',
                                  
                                  body: body);
                                  setState(() {
                                    _commentcontroller.text="";
                                   iscommentloading=false; 
                                  });
                              print(response.body);
                              getBook();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
