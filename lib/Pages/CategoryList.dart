import 'package:flutter/material.dart';
class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  TextEditingController search=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("Category List",style: TextStyle(fontFamily: 'Roboto'),),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20.0,top: 20),
            child: Container(
              width: 370,
              height: 45,
              child: TextFormField(
                controller: search,
                decoration: InputDecoration(
                  hintText: "Enter Category Name",
                  suffixIcon: InkWell
                    (
                      onTap: (){
                        //selectBhk();
                      },
                      child: Icon(Icons.search,color: Colors.deepPurpleAccent,size: 30,)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7.0)
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text("Category Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.black,letterSpacing: 0.5),),
              ),
              Container(
                margin: EdgeInsets.only(left: 80),
                child: Text("Categoty Type",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.black,letterSpacing: 0.5),),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Flexible(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: 20,
                  itemBuilder: (context,index){
                  return Card(
                    elevation: 3,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: ExpansionTile(
                        trailing: SizedBox.shrink(),
                        title:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              child: Text("Operational",style: TextStyle(fontFamily: 'Roboto'),),
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 120),
                                child: Text("Analytical",style: TextStyle(fontFamily: 'Roboto'),)),
                          ],
                        ),
                        children: <Widget>[
                         /* Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(" Payment Mode :",style: TextStyle(color: Colors.deepPurpleAccent,fontSize: 15),),
                                  Text("Bank Transfers"),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(" Description:",style: TextStyle(color: Colors.deepPurpleAccent,fontSize: 17),),
                                  SizedBox(height: 15,),
                                  Text("This Payment is done by Mobile payment"),
                                ],
                              )
                            ],
                          )*/
                        ],),
                    ),
                  );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
