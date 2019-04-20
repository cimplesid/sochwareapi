import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sochwareapi/screen/book.dart';

class Firstpage extends StatefulWidget {
  @override
  _FirstpageState createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  final String background = 'images/aww.jpg';
  GlobalKey<FormState> _formkey = GlobalKey();
  String username = "";
  String password = "";
  String message = "";
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(background), fit: BoxFit.cover)),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.black.withOpacity(0.7),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Container(
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(
                        height: 100.0,
                      ),
                      Text(
                        "Flutter Nepal's",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                        ),
                      ),
                      Text(
                        message,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        "Sochware api app",
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 100.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) return 'Username can\'t be empty';
                          return null;
                        },
                        onSaved: (value) {
                          username = value;
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Username",
                          hintStyle: TextStyle(color: Colors.white70),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) return 'Password can\'t be empty';
                          return null;
                        },
                        onSaved: (value) {
                          password = value;
                        },
                        // controller: ,
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.white70),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                          height: 50,
                          child: RaisedButton(
                              child: loading? CircularProgressIndicator():Text("Sign In".toUpperCase()),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              onPressed: this._onloginClicked),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Click on Signin to goto another Page!",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onloginClicked() async {
    if (!_formkey.currentState.validate()) return;
    _formkey.currentState.save();
     setState(() {
      loading = true; 
     });
    Map<String, dynamic> body = {
      'username': username,
      'password': password,
    };
    try {
      Response response =
          await post("http://flutter.sochware.com/api/login", body: body);
          setState(() {
           loading=false; 
          });
      //  print("status code = ${response.statusCode}");
      print(response.body);
      Map<String, dynamic> jsonData = json.decode(response.body);
      if (response.statusCode != 200)
        setState(() {
          message = jsonData['message'];
          
        });
      else {
        // User user =User.fromJson(jsonData['payload'][0]);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Book()));
      }
    } catch (error) {
      if (error is SocketException) {
        setState(() {});
      
      }
    }
  }
}
