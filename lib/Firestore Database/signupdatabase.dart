
import 'package:cloud_firestore/cloud_firestore.dart';
class SignUpDatabase  {
  final String uid;
  SignUpDatabase({this.uid});
  final CollectionReference data=FirebaseFirestore.instance.collection("signup");
  Future updateUserData(String name,String number,String email) async{
    return await data.doc(uid).set({
       'name':name,
       'number':number,
       'email':email,
    });

  }
}