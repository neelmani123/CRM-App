
import 'DashBoard.dart';
//import 'file:///E:/Flutter%20Project/crmapp/lib/Pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'file:///E:/Flutter%20Project/crmapp/lib/Pages/DashBoard.dart';
import 'package:flutter/services.dart';


class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController name=new TextEditingController();
  TextEditingController email=new TextEditingController();
  TextEditingController mobile =new TextEditingController();
  TextEditingController address=new TextEditingController();

  Future savaData()
  {
    Map<String, dynamic> profileData = {
      'Name': name.text,
      'Email': email.text,
      'Mobile': mobile.text,
      'Address': address.text,
    };
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection('Profile');
    collectionReference.add(profileData);
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
  }
  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
        content: new Text(value,style: TextStyle(fontSize: 17,),)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.deepPurpleAccent,),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16,top: 25,right: 16),
        child: GestureDetector(
          onTap:(){ FocusScope.of(context).unfocus();},
          child: ListView(
            children: <Widget>[
              Text("Edit Profile",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4,color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 10)
                          )
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                            image: NetworkImage("https://images.idgesg.net/images/article/2018/03/crm_customer-relationship-management-100752744-large.jpg"))
                      ),
                    ),
                   /* Positioned(
                      bottom: 0,
                        right: 0,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.green,
                                shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor
                            )
                          ),
                          child: Icon(Icons.edit,color: Colors.white,),
                        ))*/
                  ],
                ),
              ),
              SizedBox(height: 35,),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20.0),
                child: Container(
                  child: TextFormField(
                    controller: name,
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    //inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: 'Full Name'
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20.0),
                child: Container(
                  child: TextFormField(
                    controller: email,
                    autofocus: false,
                    keyboardType: TextInputType.emailAddress,
                    //inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: 'Email'
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20.0),
                child: Container(
                  child: TextFormField(
                    maxLength: 10,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: mobile,
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    //inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: 'Mobile'
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20.0),
                child: Container(
                  child: TextFormField(
                    controller: address,
                    autofocus: false,
                    keyboardType: TextInputType.streetAddress,
                    //inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        labelText: 'Full Address'
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      onPressed: (){
                      Navigator.pop(context);
                      },
                  child: Text("Cancel",style: TextStyle(fontSize: 14,letterSpacing: 2.2,color: Colors.black),),),
                  RaisedButton(
                    color: Colors.green,
                      elevation: 2,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      onPressed: (){
                      if(name.text.length==0||email.text.length==0||mobile.text.length==0||address.text.length==0){
                        showInSnackBar("Fill all field's");
                      }
                      else
                        {
                          savaData();
                        }

                      },
                    child: Text("Save",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,letterSpacing: 2.2,color: Colors.white),),
                      )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

}



