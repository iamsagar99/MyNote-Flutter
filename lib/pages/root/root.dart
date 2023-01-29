import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zippy/pages/login/login.dart';
import 'package:zippy/pages/home.dart';
import 'package:zippy/pages/splash_screen.dart';
import 'package:zippy/providers/bookData.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zippy/states/currentUser.dart';


enum AuthStatus {notLoggedIn,LoggedIn}

class OurRoot extends StatefulWidget {
  const OurRoot({Key? key}) : super(key: key);

  @override
  State<OurRoot> createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {

  AuthStatus _authStatus = AuthStatus.notLoggedIn;

  void didChangeDependencies() async{
    super.didChangeDependencies();
    
    CurrentUser _currentuser = Provider.of<CurrentUser>(context,listen: false);
    String _returnString = await _currentuser.onStartUp();
    if(_returnString == "success"){
     setState(() {
       _authStatus = AuthStatus.LoggedIn;
     });
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget retVal;

    switch (_authStatus) {
      case AuthStatus.notLoggedIn:
        retVal = OurLogin();
        break;
      case AuthStatus.LoggedIn:
        retVal = Home();
        break;
      default:retVal = OurLogin();
    }
    return retVal;

  }
}
