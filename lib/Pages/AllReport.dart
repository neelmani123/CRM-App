import 'package:flutter/material.dart';
class AllReport extends StatefulWidget {
  @override
  _AllReportState createState() => _AllReportState();
}

class _AllReportState extends State<AllReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('All Transaction'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/3,
                        height: 150,
                        child: Card(
                            margin: EdgeInsets.all(5),
                           // color: const Color(0xFFfafafa),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              highlightColor: Colors.amber,
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AllReport()));
                              },
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                   Image.asset('assets/Income.png',width: 50,),
                                    Text(
                                      'Income',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color(0xFF63316d), fontSize: 15,fontFamily: 'Roboto'),
                                    ),
                                    Text('3100.00')
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/3,
                        height: 150,
                        child: Card(
                            margin: EdgeInsets.all(5),
                            //color: const Color(0xFFfafafa),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              highlightColor: Colors.amber,
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AllReport()));
                              },
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/Expenses.png',width: 50,),
                                    Text(
                                      'Expenses',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color(0xFF63316d), fontSize: 15,fontFamily: 'Roboto'),
                                    ),
                                    Text('3100.00')
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/3,
                        height: 150,
                        child: Card(
                           margin: EdgeInsets.all(5),
                            //color: const Color(0xFFfafafa),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              highlightColor: Colors.amber,
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AllReport()));
                              },
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/Balance.png',width: 50,),
                                    Text(
                                      'Balance',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color(0xFF63316d), fontSize: 15,fontFamily: 'Roboto'),
                                    ),
                                    Text('3100.00'),
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: ()
                      {

                      },
                      child: Container(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.compare_arrows,
                                color: Color(0xFF63316d),
                                size: 25,
                              ),
                              Text('Sort')
                            ],
                          ),
                        ),
                        width: MediaQuery.of(context).size.width/2,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                         // borderRadius: BorderRadius.circular(12),
                        ),
                        //margin: EdgeInsets.only(left: 5,),
                      ),
                    ),
                    InkWell(
                      onTap: ()
                      {

                      },
                      child: Container(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.filter_alt,
                                color: Color(0xFF63316d),
                                size: 25,
                              ),
                              Text('Filter')
                            ],
                          ),
                        ),
                       // margin: EdgeInsets.only(right: 5),
                        width: MediaQuery.of(context).size.width/2,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                         // borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  itemCount: 10,
                    itemBuilder: (context,index){
                    return Text('hello');
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
