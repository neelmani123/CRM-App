import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crmapp/Api/ApiHandler.dart';
//import 'file:///E:/Flutter%20Project/crmapp/lib/Pages/CategoryList.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:toast/toast.dart';

import 'CategoryList.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController cat_name = new TextEditingController();
  List<DropdownMenuItem<String>> listDrop = [];
  String _value2;
  bool _status = true;
  final fb = FirebaseDatabase.instance.reference().child('categories');
  @override
  void initState() {
    super.initState();
    category();
  }

  /*Get Category From Api*/
  Future<String> category() async {
    final response = await http.get(
        "https://flutter-apps-eb588-default-rtdb.firebaseio.com/categories.json");
    Map user = json.decode(response.body);
    user.forEach((key, value) {
      listDrop.add(new DropdownMenuItem(
        child: Text(value['name'].toString()),
        value: value['id'].toString(),
      ));
    });
    setState(() {
      _status = false;
    });
  }

  /*Add SnapBar*/
  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: Colors.deepPurple,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        content: new Text(
          value,
          style: TextStyle(color: Colors.white, fontSize: 17),
        )));
  }

  /*Use for the category in the firestore*/
  addCategory() {
    Map<String, dynamic> addcat = {
      'category': _value2,
      'name': cat_name.text,
    };
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('AddCategory');
    collectionReference.add(addcat);
    setState(() {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext) => CategoryList()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Add Category',style: TextStyle(fontFamily: 'Roboto'),),
      ),
      body: _status
          ? Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Loading...",
                      style: TextStyle(fontSize: 24,fontFamily: 'Roboto'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            )
          : ListView(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 20),
                  child: Text(
                    "Add Category",
                    style: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,fontFamily: 'Roboto'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, left: 20, right: 20),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey)),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          iconEnabledColor: Colors.deepPurpleAccent,
                          value: _value2,
                          isExpanded: true,
                          hint: new Text(
                            'Select Category',
                            style: new TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          items: listDrop.toList(),
                          onChanged: (value) {
                            setState(() {
                              _value2 = value;
                              //_status=false;
                            });
                          })),
                  width: 300,
                  height: 50,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey)),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                    controller: cat_name,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Category Name"),
                    style: TextStyle(fontSize: 17),
                  ),
                  width: 300,
                  height: 50,
                ),
                SizedBox(
                  height: 20,
                ),
                // !_status ?_getActionData():new Container(),
                SizedBox(
                  height: 30,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey)),
                      child: RaisedButton(
                          splashColor: Colors.redAccent,
                          child: Text("Submit",
                              style: TextStyle(
                                  fontSize: 22.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold)),
                          textColor: Color(0xFFffffff),
                          color: Colors.deepPurpleAccent,
                          onPressed: () {
                            if (cat_name.text.length == 0) {
                              showInSnackBar('All Field is required...');
                            } else {
                              //_status=true;
                              addCategory();
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(7.0))),
                      width: 150,
                      height: 40,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey)),
                      child: RaisedButton(
                          splashColor: Color(0xFF0bc1f3),
                          child: Text("Cancel",
                              style: TextStyle(
                                  fontSize: 22.0,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold)),
                          textColor: Color(0xFFffffff),
                          color: Color(0xFFE57373),
                          onPressed: () {
                            /* if(email.text.length==0||pass.text.length==0)
                          {
                            Toast.show("All Field Required..", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                          }else
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DashBoard(
                            )));

                          }*/
                            Navigator.pop(context);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(7.0))),
                      width: 150,
                      height: 40,
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
