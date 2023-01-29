import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zippy/models/user.dart';

class OurDatabase{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(OurUser user) async {

    String retVal = "error";
    try{
    await _firestore.collection("users").doc(user.uid).set({
      'fulName': user.fullName,
      'email': user.email,
    });
    retVal = "success";
    }catch(e){
      print(e);
    }
    return retVal;
}
Future<OurUser> getUserInfo(String uid) async {
    OurUser retVal = OurUser(uid: '', email: '', fullName: '');

    try{
  DocumentSnapshot _docSnapshot = await _firestore.collection("users").doc(uid).get();
   retVal.uid = uid;
   retVal.fullName = _docSnapshot.get("fullName");
   retVal.email = _docSnapshot.get("email");

    }catch(e){
      print(e);
    }


    return retVal;
}
}