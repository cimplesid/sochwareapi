
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sochwareapi/screen/book.dart';

class AddBook extends StatefulWidget {
  @override
  _AddBookState createState() => _AddBookState();
}
GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
class _AddBookState extends State<AddBook> {
  GlobalKey<FormState> _formkey = GlobalKey();
  String bookname = "";
  String price = "";
  String author = "";
  String category = "";
  String langauge = "";
  String isbn = "";
  String publish = "";
  String message = "";
  String dob = "DOB";
  bool loading = false;
  Future _selectdate(BuildContext context) async {
    print('datepicker called');
    final DateTime selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(1996),
      firstDate: DateTime(1945),
      lastDate: DateTime(2019),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
         dob =selectedDate.toString();
        dob= DateFormat("y/MM/DD").format(selectedDate);

        publish = DateFormat("y/MM/DD").format(selectedDate);
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('Add book'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Form(
            key: _formkey,
                      child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return 'BookName can\'t be empty';
                    return null;
                  },
                  onSaved: (value) {
                    bookname = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Ex: Game of thrones',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.book)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return 'Price can\'t be empty';
                    return null;
                  },
                  onSaved: (value) {
                    price = value;
                  },
                  keyboardType: TextInputType.numberWithOptions(signed: true),
                  decoration: InputDecoration(
                      labelText: 'Price',
                      hintText: 'Ex: 400',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.attach_money)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return 'Author can\'t be empty';
                    return null;
                  },
                  onSaved: (value) {
                    author = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'Author',
                      hintText: 'Ex:Dr.Roshan',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(MdiIcons.account)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return 'Category can\'t be empty';
                    return null;
                  },
                  onSaved: (value) {
                    category = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'Category',
                      hintText: 'Ex: Sci-FI',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.category)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return 'Langauge can\'t be empty';
                    return null;
                  },
                  onSaved: (value) {
                    langauge = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'Langauge',
                      hintText: 'Ex: en',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.language)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return 'Isbn can\'t be empty';
                    return null;
                  },
                  onSaved: (value) {
                    isbn = value;
                  },
                  decoration: InputDecoration(
                      labelText: 'ISBN',
                      hintText: 'Ex: 123-000234',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.confirmation_number)),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade800),
                      borderRadius: BorderRadius.circular(5)),
                  child: ListTile(
                    leading: Icon(Icons.date_range),
                    title: Text(dob),
                    trailing: FlatButton(
                      onPressed: () => _selectdate(context),
                      child: Text('Select Date'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  
                  child: RaisedButton(
                    color: Colors.greenAccent.shade700,
                    child: loading?CircularProgressIndicator(backgroundColor: Colors.white,):Text('Submit'),
                    onPressed: this._onclicked,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onclicked() async {
    
    setState(() {
     loading= true; 
    });
    if (!_formkey.currentState.validate()) return;
    _formkey.currentState.save();
    Map<String, dynamic> body = {
      // "id": 23,
      "name": bookname,
      "price": price,
      "author": author,
      "category": category,
      "language": langauge,
      "isbn": isbn,
      "publish_date": publish
    };      
    print(body);

    print('json made');
    try {
      Response response =
          await post("http://flutter.sochware.com/api/addBook", body: body);
      setState(() {
       loading=false; 
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Book()));
      print(response.body);
      
    } catch (error) {
      
      _scaffoldkey.currentState
          .showSnackBar(new SnackBar(content: Text(error)));
    }
  }
}
