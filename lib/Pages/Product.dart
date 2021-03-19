import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'file:///E:/Flutter%20Project/crmapp/lib/Pages/DashBoard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:crmapp/Api/ApiHandler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

import 'DashBoard.dart';

class Product extends StatefulWidget {
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController pro_name = new TextEditingController();
  TextEditingController pro_qty = new TextEditingController();
  TextEditingController pro_price = new TextEditingController();
  TextEditingController pro_discount = new TextEditingController();
  TextEditingController pro_sale_price = new TextEditingController();
  String _value2;
  List<DropdownMenuItem<String>> listDrop = [];
  Map data;
  bool _isLoading=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    product_cat();
  }
/*This Method is use get Category From the Api */
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
/*This Method is use for the Store Data in the FireStore Database*/
  addData() {
    Map<String, dynamic> productdata = {
      'name': pro_name.text,
      'quantity': pro_qty.text,
      'sale price': pro_sale_price.text,
      'product price': pro_price.text,
      'product discount': pro_discount.text,
      'product category': _value2,
    };

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('Product');
    collectionReference.add(productdata);
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Product",style: TextStyle(fontFamily: 'Roboto'),),
        leading:  new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashBoard()),
            );
          },
        ),
      ),
      body: _isLoading?Container(child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Loading...",style: TextStyle(fontSize: 24),),
            SizedBox(height: 10,),
            CircularProgressIndicator(),
          ],
        ),
      ),): ListView(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Text(
              "Add Product",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20.0),
            child: Container(
              child: TextFormField(
                keyboardType: TextInputType.text,
                autofocus: false,
                controller: pro_name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    labelText: 'Product Name'),
              ),
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
                controller: pro_qty,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    labelText: 'Product Quantity'),
              ),
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
                controller: pro_sale_price,
                autofocus: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    labelText: 'Product Sale Price'),
              ),
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
                controller: pro_price,
                autofocus: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    labelText: 'Product Price'),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20.0),
            child: Container(
              child: TextFormField(
                keyboardType: TextInputType.number,
                autofocus: false,
                controller: pro_discount,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    labelText: 'Product Discount'),
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
                      'Product Category',
                      style: new TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Roboto'
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
                        if (pro_name.text.length == 0 ||
                            pro_qty.text.length == 0 ||
                            pro_price.text.length == 0 ||
                            pro_discount.text.length == 0) {
                          showInSnackBar('All Field is required...');
                        } else {
                         addData();
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
