import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:crmapp/Api/ApiHandler.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'DashBoard.dart';
//import 'file:///E:/Flutter%20Project/crmapp/lib/Pages/DashBoard.dart';

class AddIncome extends StatefulWidget {
  @override
  _AddIncomeState createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  bool _isLoading=true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController amount=new TextEditingController();
  TextEditingController description=new TextEditingController();
  List<DropdownMenuItem<String>> listDrop = [];
  List<DropdownMenuItem<String>> listDrop1 = [];
  Map data;
  String _value2,select1;
  DateTime _date = DateTime.now();
  //TimeOfDay _time=TimeOfDay.now();
  //TimeOfDay picked;
  String _formatteddate="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    product_cat();
    payment_type();
  }
  //Time Picker Dialog
 /* Future<TimeOfDay > selectTime (BuildContext context)async{
    picked=await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now());
    if(picked!=null )
      {
        setState(() {
      _time=picked;
      print(_time);
    });

      }

  }*/
  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: Colors.deepPurple,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        content: new Text(value,style: TextStyle(color: Colors.white,fontSize: 17),)
    ));
  }
  Future product_cat() async {
    final response =
    await http.get(ApiHandler.BASE_URL + "product_category.json");
    Map res = json.decode(response.body);
    res.forEach((key, value) {
      listDrop.add(new DropdownMenuItem(
        child: Text(value['type'].toString()),
        value: value['type'].toString(),
      ));
    });
    setState(() {
      _isLoading=false;
    });
  }
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

  addIncome(){
    Map<String, dynamic> addincome = {
      'amount': amount.text,
      'category': _value2,
      'date':_formatteddate,
      //'time': "${_time.hour.toString()}:${_time.minute}",
      'description': description.text,
      'payment_type': select1,
    };
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection('AddIncome');
    collectionReference.add(addincome);
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
  }

  @override
  Widget build(BuildContext context) {
    _formatteddate = new DateFormat.yMMMd().format(_date);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Add Income",style: TextStyle(fontFamily: 'Roboto'),),
      ),
      body:_isLoading?Container(child: Center(
        child: CircularProgressIndicator(),
      ),):  ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Text(
              "Add Income",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,fontFamily: 'Roboto'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20.0),
            child: Container(
              child: TextFormField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                autofocus: false,
                enabled: true,
                controller: amount,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    labelText: 'Amount'),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(top: 5, left: 20, right: 20),
            padding: EdgeInsets.only(left: 15, right: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey)),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    value: _value2,
                    isExpanded: true,
                    //value: selected2,
                    hint: new Text(
                      'Category',
                      style: new TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    items: listDrop.toList(),
                    onChanged: (value) {
                      setState(() {
                        _value2 = value;
                      });
                    })),
            width: 300,
            height: 50,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10,
              left: 20,
              right: 20
            ),
            padding: EdgeInsets.only(top: 5, left: 20,right: 20),
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
              child: Row(
                children: [
                  Text(
                    "${_formatteddate} ",
                    style: TextStyle( fontSize: 17),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_drop_down,color: Colors.deepPurpleAccent,size: 25,)
                ],
              )
            ),
            width: 120,
            height: 50,
          ),
          //Time Field Dialog
          /*SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(
                top: 10,
                left: 20,
                right: 20
            ),
            padding: EdgeInsets.only(top: 5, left: 20,right: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey)),
            child: InkWell(
              onTap: () {
                setState(() {
                selectTime(context);
                });
              },
              child: Row(
                children: [
                  Text(
                    "${_time.hour.toString()}:${_time.minute}",
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                  Spacer(),
                  Icon(Icons.arrow_drop_down,color: Colors.deepPurpleAccent,size: 25,)
                ],
              )
            ),
            width: 120,
            height: 50,
          ),*/
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20,),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey)
                  ),
                  child:TextField(
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                    controller: description,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: false,
                        hintText: "Description"
                    ),
                    style: TextStyle(fontSize: 17),
                  ),
                  width: MediaQuery. of(context). size. width* 0.90,
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.only(top: 20,left: 20,right: 20),
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey)
            ),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    value: select1,
                    isExpanded: true,
                    hint: new Text(
                      'Payment Type',
                      style: new TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    items: listDrop1.toList(),
                    onChanged: (value){
                      setState(() {
                        select1=value;
                      });
                    })),
            width: 180,
            height: 50,
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  width: 100,
                  height: 50, // specific value
                  child: RaisedButton(
                      splashColor: Color(0xFF0bc1f3),
                      child: Text("Submit",
                          style: TextStyle(
                              fontSize: 22.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold)),
                      textColor: Color(0xFFffffff),
                      color: Colors.deepPurpleAccent,
                      onPressed: () async {
                        if (amount.text.length == 0 ||
                            description.text.length == 0
                            ) {
                          showInSnackBar('All Field is required...');
                        } else {
                          addIncome();
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(7.0))),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
