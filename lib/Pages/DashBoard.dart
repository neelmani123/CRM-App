//import 'file:///E:/Flutter%20Project/crmapp/lib/Pages/AddExpenseTwo.dart';
//import 'file:///E:/Flutter%20Project/crmapp/lib/Pages/LoginPage.dart';
import 'package:crmapp/Pages/Product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'file:///E:/Flutter%20Project/crmapp/lib/Pages/AddExpenseType.dart';
//import 'file:///E:/Flutter%20Project/crmapp/lib/Pages/Profile.dart';
//import 'file:///E:/Flutter%20Project/crmapp/lib/Pages/Category.dart';
import 'package:toast/toast.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'AddExpenseType.dart';
import 'AddIncome.dart';
import 'Category.dart';
import 'LoginPage.dart';
import 'Profile.dart';
//import 'file:///E:/Flutter%20Project/crmapp/lib/Pages/AddIncome.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  FirebaseAuth _auth = FirebaseAuth.instance;
  static var chartdisplay;
  String email="";
  /*The Method is Use LogOut*/
  Future<void> logOut() async {
    await _auth.signOut().then((value) {
      User user = _auth.currentUser;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
      print(user);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getEmail();
    super.initState();
    setState(() {
      var data = [
        addCharts("Sun", 10, Colors.deepPurpleAccent),
        addCharts("Mon", 40, Colors.red),
        addCharts("Tue", 30, Colors.blue),
        addCharts("Wed", 60, Colors.yellow),
        addCharts("Thu", 80, Colors.green),
        addCharts("Fri", 100, Colors.amberAccent),
        addCharts("Sat", 70, Colors.amber),
      ];
      var series = [
        charts.Series(
          domainFn: (addCharts addcharts, _) => addcharts.label,
          measureFn: (addCharts addcharts, _) => addcharts.value,
          colorFn: (addCharts addcharts, _) =>
              charts.ColorUtil.fromDartColor(addcharts.colorVal),
          id: 'addcharts',
          data: data,
          labelAccessorFn: (addCharts addcharts, _) => '${addcharts.value}',
          fillPatternFn: (_, __) => charts.FillPatternType.solid,
          // fillColorFn: (addCharts addCharts,_)=>charts.ColorUtil.fromDartColor(Color(0xff109618)),
        )
      ];

      chartdisplay = charts.BarChart(
        series,
        animationDuration: Duration(milliseconds: 2000),
        animate: true,
        barGroupingType: charts.BarGroupingType.grouped,
        // behaviors: [new charts.SeriesLegend()],
      );
    });


  }
  //get Email Id in shared prefrence...
  Future getEmail()async
  {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    setState(() {
      email=preferences.getString('email_id');
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      appBar: AppBar(
        title: Text("DashBoard",style: TextStyle(fontFamily: 'Roboto'),),
        elevation: 0.0,
        backgroundColor: Colors.deepPurpleAccent,
        actions: <Widget>[
          PopupMenuButton(
              elevation: 10.0,
              onSelected: (value) {
                if (value == 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              EditProfilePage()));
                } else if (value == 2) {
                  print("Setting is clicked");
                } else {
                  logOut();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "M",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              itemBuilder: (context) => [
                    PopupMenuItem(
                        value: 1,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.person),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text("Profile",style: TextStyle(fontFamily: 'Roboto'),),
                            )
                          ],
                        )),
                    PopupMenuItem(
                        value: 2,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.settings),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text("Settings",style: TextStyle(fontFamily: 'Roboto'),),
                            )
                          ],
                        )),
                    PopupMenuItem(
                        value: 3,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.person),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text("Logout",style: TextStyle(fontFamily: 'Roboto'),),
                            )
                          ],
                        )),
                  ]),
        ],
      ),
      backgroundColor: Colors.white,
      drawer: Drawer(
        elevation: 5,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            /*ListTile(
              contentPadding: EdgeInsets.only(top: 20),
              title: Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.deepPurpleAccent,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),*/
           DrawerHeader(
             decoration: BoxDecoration(
               color: Colors.deepPurpleAccent,
             ),
             child:Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 new CircleAvatar(
                     radius: 30.0,
                     child: Icon(
                       Icons.assignment,
                       size: 50,
                     )
                   //  CachedNetworkImage(
                   //   imageUrl:
                   //       'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTnx9gugwptmYiJSoH38ftixCTsOiX86pseDJUG8nTONwADCQUS',
                   //   placeholder: (context, url) =>
                   //       CircularProgressIndicator(),
                   //   errorWidget: (context, url, error) => Icon(Icons.person),
                   // ),
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                   child: Text("${email?.isEmpty ?? true ? "" : email}",style: TextStyle(fontSize: 17,color: Colors.white),),
                 ),
               ],
             ),
           ),

            ListTile(
              leading: Icon(Icons.person),
              title: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Text(
                  'My Profile',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF1d1d1d),
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => EditProfilePage()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.wallet_travel_outlined),
              title: Text(
                'Expenses',
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF1d1d1d),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AddExpenseType()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.wallet_travel_outlined),
              title: Text(
                'Add Income',
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF1d1d1d),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AddIncome()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.category),
              title: Text(
                'Category ',
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF1d1d1d),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AddCategory()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text(
                'Product',
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF1d1d1d),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext) => Product()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.perm_contact_cal),
              title: Text(
                'Contact Us',
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF1d1d1d),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
            Center(child: Text("1.0.3",style: TextStyle(fontSize: 20,color: Colors.deepPurpleAccent),))
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // onTap: _onItemTapped,
        //currentIndex: _currentSelected,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey[800],
        selectedItemColor: Color.fromRGBO(10, 135, 255, 1),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('Page 1'),
            icon: Icon(Icons.access_alarm),
          ),
          BottomNavigationBarItem(
            title: Text('Page 2'),
            icon: Icon(Icons.accessible),
          ),
          BottomNavigationBarItem(
            title: Text('Page 3'),
            icon: Icon(Icons.adb),
          ),
          BottomNavigationBarItem(
            title: Text('Page 4'),
            icon: Icon(Icons.accessibility_new),
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          /* SizedBox(
            height: 150,
            width: double.infinity,
          ),*/
          Container(
            height: MediaQuery.of(context).size.height / 3,
            child: chartdisplay,
          ),
          GridView.count(
            crossAxisCount: 3,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            physics: ScrollPhysics(), // to disable GridView's scrolling
            shrinkWrap: true,
            children: <Widget>[
              Card(
                shape: StadiumBorder(
                  side: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                elevation: 5,
                color: const Color(0xFFfafafa),
                child: InkWell(
                  borderRadius: BorderRadius.circular(55),
                  highlightColor: Colors.amber,
                  onTap: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Capacitymodule()));
                  },
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.compare_arrows_outlined,
                          color: Color(0xFF63316d),
                          size: 30,
                        ),
                        Text(
                          'Transaction',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Color(0xFF63316d), fontSize: 15,fontFamily: 'Roboto'),
                        ),
                      ],
                    ),
                  ),
                ),
                margin: EdgeInsets.all(10.0),
              ),
              Card(
                  elevation: 5,
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  margin: EdgeInsets.all(10.0),
                  color: const Color(0xFFfafafa),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(55),
                    highlightColor: Colors.amber,
                    onTap: () {
                      //  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Refernce_material()));
                    },
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.receipt_long_outlined,
                            color: Color(0xFF63316d),
                            size: 30,
                          ),
                          Text(
                            'Sales',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF63316d), fontSize: 15,fontFamily: 'Roboto'),
                          ),
                        ],
                      ),
                    ),
                  )),
              Card(
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(10.0),
                  color: const Color(0xFFfafafa),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(55),
                    highlightColor: Colors.amber,
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Faq()));
                    },
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.wallet_travel_outlined,
                            color: Color(0xFF63316d),
                            size: 30,
                          ),
                          Text(
                            'Add Expenses',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF63316d), fontSize: 15,fontFamily: 'Roboto'),
                          ),
                        ],
                      ),
                    ),
                  )),
              Card(
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(10.0),
                  color: const Color(0xFFfafafa),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(55),
                    highlightColor: Colors.amber,
                    onTap: () {
                      //  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Feed()));
                    },
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.wallet_giftcard,
                            color: Color(0xFF63316d),
                            size: 30,
                          ),
                          Text(
                            'Add Income',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF63316d), fontSize: 15,fontFamily: 'Roboto'),
                          ),
                        ],
                      ),
                    ),
                  )),
              Card(
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(10.0),
                  color: const Color(0xFFfafafa),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(55),
                    highlightColor: Colors.amber,
                    onTap: () {
                      //  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Stories()));
                    },
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.settings,
                            color: Color(0xFF63316d),
                            size: 30,
                          ),
                          Text(
                            'Settings',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF63316d), fontSize: 15,fontFamily: 'Roboto'),
                          ),
                        ],
                      ),
                    ),
                  )),
              Card(
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  elevation: 5,
                  color: const Color(0xFFfafafa),
                  margin: EdgeInsets.all(10.0),
                  // color:  Color(0xFFffc107),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(55),
                    highlightColor: Colors.amber,
                    onTap: () {
                      //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HomePage()));
                    },
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.star_rate_sharp,
                            color: Color(0xFF63316d),
                            size: 30,
                          ),
                          Text(
                            'Rate Us',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF63316d), fontSize: 15,fontFamily: 'Roboto'),
                          ),
                        ],
                      ),
                    ),
                  )),
              //!_status ? _getActionButtons() : new Container(),
              Card(
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(10.0),
                  color: const Color(0xFFfafafa),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(55),
                    highlightColor: Colors.amber,
                    onTap: () {
                      //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Reporting()));
                    },
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.report,
                            color: Color(0xFF63316d),
                            size: 30,
                          ),
                          Text(
                            'Report',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF63316d), fontSize: 15,fontFamily: 'Roboto'),
                          ),
                        ],
                      ),
                    ),
                  )),
              Card(
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(10.0),
                  color: const Color(0xFFfafafa),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(55),
                    highlightColor: Colors.amber,
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HopitalPlan()));
                    },
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          //Image.asset("assets/dashboard/group.png"),
                          SizedBox(
                            height: 18.0,
                          ),
                          Text(
                            'Hospital Plan',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Color(0xFF63316d),fontFamily: 'Roboto'),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class addCharts {
  final String label;
  final int value;
  final Color colorVal;
  addCharts(this.label, this.value, this.colorVal);
}
