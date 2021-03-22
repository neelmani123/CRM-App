import 'dart:convert';
import 'package:crmapp/Api/ApiHandler.dart';
import 'package:crmapp/Pages/ModelClass.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:http/http.dart' as http;

import 'AddExpenseTwo.dart';

class AddExpenseType extends StatefulWidget {
  @override
  _AddExpenseTypeState createState() => _AddExpenseTypeState();
}

class _AddExpenseTypeState extends State<AddExpenseType> {
  DateTime _date = DateTime.now();
  DateTime _date1 = DateTime.now();
  List<DropdownMenuItem<String>> listDrop = [];
  List<DropdownMenuItem<String>> listDrop1 = [];
  String _value, _value2;
  Map res;
  List data = [];
  List data1 = [];
  Model model;
  String query = '';
  var amount = 0;
  bool _isLoading = true;

/*This Method is use for the Date Picker Dialog*/
  Future<Null> selectDate(BuildContext context) async {
    DateTime _datePicker = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (_datePicker != null && _datePicker != _date) {
      setState(() {
        _date = _datePicker;
      });
    }
  }

/*This Method is use for the Date Picker Dialog1*/
  Future<Null> selectDate1(BuildContext context) async {
    DateTime _datePicker = await showDatePicker(
        context: context,
        initialDate: _date1,
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));
    if (_datePicker != null && _datePicker != _date1) {
      setState(() {
        _date1 = _datePicker;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    payment_mode();
    payment_type();
    addExpense();
  }

/*This Method is use for the get Payment_mode From the Api*/
  Future payment_mode() async {
    final response = await http.get(ApiHandler.BASE_URL + "payment_mode.json");
    Map res = json.decode(response.body);
    res.forEach((key, value) {
      listDrop.add(new DropdownMenuItem(
        child: Text(value['type'].toString()),
        value: value['type'].toString(),
      ));
    });
    setState(() {});
  }

/*This Method is use for the get Payment_type From the Api*/
  Future payment_type() async {
    final response = await http.get(ApiHandler.BASE_URL + "payment_type.json");
    Map res = json.decode(response.body);
    res.forEach((key, value) {
      listDrop1.add(new DropdownMenuItem(
        child: Text(value['type'].toString()),
        value: value['type'].toString(),
      ));
    });
    setState(() {
      //query=_value;
    });
  }

/*This Method is use for the get EXpense From The Api*/
  Future addExpense() async {
    final response = await http.get(ApiHandler.BASE_URL + "Add Expense.json");
    res = json.decode(response.body);
    print(res);
    res.forEach((key, value) {
      model = new Model(
          payment_type: value['payment_type'],
          payment_mode: value['payment_mode'],
          date: value['date'],
          amount: value['amount'],
          description: value['description'],
          key: key);
      setState(() {
        //print(value['payment_type']);
        data.add(value);
        data1.add(value);
        amount = amount + int.parse(value['amount']);
        print("Amount is:=$amount");
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String _formatteddate = new DateFormat.yMMMd().format(_date);
    String _formatteddate1 = new DateFormat.yMMMd().format(_date1);
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text("Expense"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => AddExpenseTwo()));
          } else {
            print("Not select any index");
          }
        },
        //currentIndex: _currentSelected,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey[800],
        selectedItemColor: Colors.deepPurpleAccent,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('Expense List'),
            icon: Icon(Icons.access_alarm),
          ),
          BottomNavigationBarItem(
            title: Text('Add expense Type'),
            icon: Icon(Icons.access_alarm),
          ),
          BottomNavigationBarItem(
            title: Text('Expense Add'),
            icon: Icon(Icons.adb),
          ),
          BottomNavigationBarItem(
            title: Text('Add Type'),
            icon: Icon(Icons.accessibility_new),
          )
        ],
      ),
      body: new Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 40),
                child: Text(
                  "Payment Type",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      //fontFamily: 'Pacifico',
                      color: Colors.black),
                ),
              ),
              Container(
                // margin: EdgeInsets.only(left: 105),
                child: Text(
                  "Payment Mode",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      // fontFamily: 'Pacifico',
                      color: Colors.black),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: 5,
                ),
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey)),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: _value,
                        isExpanded: true,
                        //value: selected2,
                        hint: new Text(
                          'Payment Type',
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                        items: listDrop1.toList(),
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                            query = _value;
                            print(query);
                          });
                        })),
                width: 180,
                height: 40,
              ),
              Container(
                margin: EdgeInsets.only(top: 5, left: 10),
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey)),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: _value2,
                        isExpanded: true,
                        //value: selected2,
                        hint: new Text(
                          ' Payment Mode',
                          style: new TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                        items: listDrop.toList(),
                        onChanged: (value) {
                          setState(() {
                            _value2 = value;
                            query = _value2;
                          });
                        })),
                width: 180,
                height: 40,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 40),
                child: Text(
                  "Form Date",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black),
                ),
              ),
              Container(
                // margin: EdgeInsets.only(left: 75),
                child: Text(
                  "To Date",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 95),
                child: Text(
                  "",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black),
                ),
              ),
            ],
          ),
          /*This Row is Button and To Date*/
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                ),
                padding: EdgeInsets.only(top: 10, left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey)),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectDate(context);
                      print(_formatteddate);
                    });
                  },
                  child: Text(
                    "${_formatteddate} ",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
                width: 120,
                height: 40,
              ),
              Container(
                margin: EdgeInsets.only(left: 10, top: 10),
                padding: EdgeInsets.only(top: 10, left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey)),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectDate1(context);
                    });
                  },
                  child: Text(
                    "${_formatteddate1}",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
                width: 120,
                height: 40,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.grey)),
                child: RaisedButton(
                    splashColor: Colors.redAccent,
                    child: Text("Submit",
                        style: TextStyle(
                          fontSize: 22.0,
                          //   fontFamily: 'Pacifico',
                        )),
                    textColor: Color(0xFFffffff),
                    color: Colors.deepPurpleAccent,
                    onPressed: () {
                      setState(() {
                        data1 = data
                            .where((element) =>
                                element['payment_type']
                                    .toString()
                                    .toLowerCase()
                                    .contains(query.toString().toLowerCase()) ||
                                element['payment_mode']
                                    .toString()
                                    .toLowerCase()
                                    .contains(query.toString().toLowerCase()))
                            .toList();
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(7.0))),
                width: 120,
                height: 40,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              height: 20,
              color: Colors.black,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                //margin: EdgeInsets.only(left: 5),
                child: Text(
                  "Payment Type",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 50),
                child: Text(
                  "Date",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 100,right: 40 ),
                child: Text(
                  "Price",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black),
                ),
              ),
            ],
          ),
          _isLoading
              ? Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.red,
                      ),
                      //child: Text("Loading..."),
                    ),
                  ),
                )
              : Flexible(
                  child: Container(
                        margin: EdgeInsets.only(top: 10),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: query.isEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  data == null ? Container() : data.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(1),
                                    child: ExpansionTile(
                                     // trailing: Wrap(),
                                      title:  Container(
                                        width: 100,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(child: Text(data[index]['payment_type'])),
                                            Expanded(
                                              child: Container(
                                       //       padding: EdgeInsets.only(left: 100),
                                                child: Text(
                                                  data[index]['date'],
                                                ),
                                              ),
                                            ),
                                            Container(
                                         //    padding: EdgeInsets.only(left: 50),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/rupee.png',
                                                    color: Colors.black,
                                                    width: 15,
                                                  ),
                                                  Text(
                                                    data[index]['amount'],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  " Payment Mode :",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .deepPurpleAccent,
                                                      fontSize: 17),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                  child: Text(
                                                      data[index]
                                                          ['payment_mode'],
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  " Description:",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .deepPurpleAccent,
                                                      fontSize: 17),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 50),
                                                  child: Text(data[index]
                                                      ['description']),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  data1 == null ? Container() : data1.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(1),
                                    child: ExpansionTile(
                                      trailing: SizedBox.shrink(),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                                data1[index]['payment_type']),
                                          ),
                                          Expanded(
                                            child: Container(
                                               // margin: EdgeInsets.only(left: 100),
                                                child:
                                                    Text(data1[index]['date'])),
                                          ),
                                          Expanded(
                                            child: Container(
                                               //  margin: EdgeInsets.only(left: 70),
                                                child:
                                                    Text(data1[index]['amount'])),
                                          ),
                                        ],
                                      ),
                                      children: <Widget>[
                                        Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                          //crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  " Payment Mode :",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .deepPurpleAccent,
                                                      fontSize: 15),
                                                ),
                                                Text(data1[index]
                                                    ['payment_mode']),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  " Description:",
                                                  style: TextStyle(
                                                      color: Colors
                                                          .deepPurpleAccent,
                                                      fontSize: 17),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Text(data1[index]
                                                    ['description']),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              })
                  ),
                ),
          SlidingUpPanel(
            minHeight: 30,
            maxHeight: 200,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            panelBuilder: (sc) => _panel(sc),
          )
        ],
      ),
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        child: ListView(
          controller: sc,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            SizedBox(
              height: 18.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Total Amount",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 24.0,
                      color: Colors.deepPurpleAccent),
                ),
              ],
            ),
            SizedBox(
              height: 36.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/rupee.png',
                  color: Colors.deepPurpleAccent,
                  width: 20,
                ),
                Text(
                  " $amount",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ],
            )
          ],
        ));
  }
}
