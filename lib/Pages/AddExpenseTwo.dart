import 'dart:convert';
import 'package:crmapp/Api/ApiHandler.dart';
import 'package:flutter/cupertino.dart';
//import 'package:crmapp/lib/Pages/DashBoard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:toast/toast.dart';

import 'DashBoard.dart';
class AddExpenseTwo extends StatefulWidget {
  @override
  _AddExpenseTwoState createState() => _AddExpenseTwoState();
}

class _AddExpenseTwoState extends State<AddExpenseTwo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController amount=new TextEditingController();
  TextEditingController description=new TextEditingController();
  List<DropdownMenuItem<String>> listDrop = [];
  List<DropdownMenuItem<String>> listDrop1 = [];
  String select,select1;
  String title='Date Picker';
  DateTime _date=DateTime.now();
  String _formatteddate;
  bool _isLoading=true;
  Map res;
  var amount1 = 0;
  List data = [];

  final databaseReference = FirebaseDatabase.instance.reference();
  Future<Null> selectDate(BuildContext context)
  async {
    DateTime _datePicker=await showDatePicker(context: context,
        initialDate: _date,
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));
    if(_datePicker!=null && _datePicker!=_date)
    {
      setState(() {
        _date=_datePicker;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    payment_mode();
    payment_type();
    getExpense();
  }
  Future payment_mode() async
  {
    final response=await http.get(ApiHandler.BASE_URL+"payment_mode.json");
    Map res=json.decode(response.body);
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
  Future payment_type() async
  {
    final response=await http.get(ApiHandler.BASE_URL+"payment_type.json");
    Map res=json.decode(response.body);
    res.forEach((key, value) {
      listDrop1.add(new DropdownMenuItem(
        child: Text(value['type'].toString()),
        value: value['type'].toString(),
      ));
    });
    setState(() {
      _isLoading=false;
    });
  }

  Future addExpense() async{
    await databaseReference.child("Add Expense").push().set({
      'payment_mode':select,
      "payment_type":select1,
      "date":_formatteddate,
      "amount":amount.text,
      "description":description.text,
    });
    print(select.toString());
    print(select1.toString());
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DashBoard(
    )));
  }
  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: Colors.deepPurple,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        content: new Text(value,style: TextStyle(color: Colors.white,fontSize: 17),)
    ));
  }

  /*This Method is use for the get EXpense From The Api*/
  Future getExpense() async {
    final response = await http.get(ApiHandler.BASE_URL + "Add Expense.json");
    res = json.decode(response.body);
    print(res);
    res.forEach((key, value) {
      setState(() {
        //print(value['payment_type']);
        data.add(value);
        amount1 = amount1 + int.parse(value['amount']);
       // print("Amount is:=$amount1");

        _isLoading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    _formatteddate=new DateFormat.yMMMd().format(_date);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text("Add Expense Type"),),
      body: _isLoading?Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Loading...",style: TextStyle(fontSize: 24),),
              SizedBox(height: 10,),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ):SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.only(left: 20.0,top: 20),
              child: Text("Add Expense ",style: TextStyle(
                  fontSize: 20,
                  color: Colors.deepPurpleAccent,
                  fontWeight: FontWeight.bold
              ),),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey)
                    ),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            value: select,
                            isExpanded: true,
                            //value: selected2,
                            hint: new Text(
                              'Payment Mode',
                              style: new TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                            items:listDrop.toList(),
                            onChanged: (value){
                              select=value;
                              setState(() {
                                select=value;
                              });
                            })),
                    width: 180,
                    height: 40,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
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
                                color: Colors.black,
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
                    height: 40,
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20,left: 10),
                  padding: EdgeInsets.only(top: 10,left: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey)
                  ),
                  child:InkWell(
                    onTap: (){
                      setState(() {
                        selectDate(context);
                      });
                    },
                    child: Text("${_formatteddate}",style: TextStyle(color: Colors.black,fontSize: 17),),
                  ),
                  width: 180,
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(color: Colors.grey)
                        ),
                        child:TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          controller: amount,
                          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: false,
                              hintText: "Amount"
                          ),
                          style: TextStyle(fontSize: 18,color: Colors.black),
                        ),
                        width: 180,
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ],
            ),
           // SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey)
                    ),
                    child:TextField(
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,
                      controller: description,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: false,
                          hintText: "Description"
                      ),
                      style: TextStyle(fontSize: 18,color: Colors.black),
                    ),
                    width: 350,
                    height: 100,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey)
                    ),
                    child: RaisedButton(
                        splashColor: Colors.redAccent,
                        child: Text("Submit",style: TextStyle(fontSize: 22.0,fontFamily: 'Avenir Heavy',fontWeight: FontWeight.bold)),
                        textColor: Color(0xFFffffff),
                        color: Colors.deepPurpleAccent,
                        onPressed: () {
                          if(amount.text.length==0||description.text.length==0)
                          {
                            //Toast.show("All Field Required..", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                            showInSnackBar('All Field Required..');
                          }else
                          {
                            addExpense();

                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            new BorderRadius.circular(
                                7.0))),
                    width: 150,
                    height: 40,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey)
                    ),
                    child: RaisedButton(
                        splashColor: Color(0xFF0bc1f3),
                        child: Text("Cancel",style: TextStyle(fontSize: 22.0,fontFamily: 'Avenir Heavy',fontWeight: FontWeight.bold)),
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
                            borderRadius:
                            new BorderRadius.circular(
                                7.0))),
                    width: 150,
                    height: 40,
                  ),
                ],
              ),
            ),
            Divider(height: 10,color: Colors.deepPurpleAccent,endIndent: 10,indent: 10,thickness: 2,),
            Container(
              height: MediaQuery.of(context).size.height,
              child:ListView.builder(
                reverse: true,
                  shrinkWrap: true,
                 itemCount:data.length,
                  itemBuilder: (Context,index){
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(1),
                        child: ExpansionTile(
                          trailing: SizedBox.shrink(),
                          title:  Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(data.last['payment_type']),
                              Text(
                                data.last['date'],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/rupee.png',
                                    color: Colors.black,
                                    width: 15,
                                  ),
                                  Text(
                                    data.last['amount'],
                                  ),
                                ],
                              ),
                            ],
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
                                          data.last
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
                                      child: Text(data.last
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
            )
          ],
        ),

      ),
    );
  }

}