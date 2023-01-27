import 'package:flutter/material.dart';
import 'package:zippy/widgets/loginform.dart';

class OurLogin extends StatelessWidget {
  const OurLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: ListView(
            padding: EdgeInsets.all(20.0),
            children: <Widget>[
              Padding(padding: EdgeInsets.all(40.0),child: Image.asset('assets/images/book.jpeg'),),
              SizedBox(height: 20,),
              OurLoginForm()
            ],
          ))
        ],
      ),
    );
  }
}

