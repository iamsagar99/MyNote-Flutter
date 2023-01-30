import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:zippy/models/user.dart';
import 'package:zippy/services/database.dart';


class CurrentUser extends ChangeNotifier{
  OurUser _currentUser = OurUser(uid: '', email: '', fullName: '');
  String _uid='';
  String _email='';
  String get getUid => _uid;
  String get email => _email;
  FirebaseAuth _auth = FirebaseAuth.instance;


  Future <String>onStartUp() async {
    String retVal = "error";
  try{
    final User? user = await _auth.currentUser;
    // _uid = user?.uid ?? '';
    // _email = user?.email?? '';
    // retVal = "success";
    if(user != null){
      _currentUser = await OurDatabase().getUserInfo( user?.uid ?? '');
      if(_currentUser!= null){
        retVal = "success";
      }
    }
  }catch(e){
    print(e);
  }
    return retVal;
  }

  Future <String>signOut() async {
    String retVal = "error";
    try{
       await _auth.signOut();
      _uid = '';
      _email = '';
      retVal = "success";
    }catch(e){
      print(e);
    }
    return retVal;
  }

  Future<String>  SignUpUser(String email,String password,String fulName) async{
    String retVal = "error";
    OurUser _user = OurUser(uid: '', email: '', fullName: '');

    try{
      UserCredential _authResult =  await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _user.uid =  _authResult.user?.uid ?? '';
      _user.email =  _authResult.user?.email ?? '';
      _user.fullName =  fulName;
       String _returnString = await OurDatabase().createUser(_user);
       if(_returnString == "success"){
         retVal = "success";
       }
    } on PlatformException catch(e){
      retVal = e.toString();
    }
    catch(e){
      print(e.toString());
    }
    return retVal;
  }




  Future<String>  LoginUserWithEmail(String email,String password) async {
    String retVal = "error";

    try{
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
        //
        // _uid = _authResult.user?.uid ?? '';
        // _email = _authResult.user?.email ?? '';
        // retVal = "success";
      _currentUser = await OurDatabase().getUserInfo(_authResult.user?.uid ?? '');
      if(_currentUser!=null){
        retVal = "success";
        print("\n_____________________________________________________\n");
        print(_currentUser);
      }
    }catch(e){
      print(e);
    }
    return retVal;  }

}