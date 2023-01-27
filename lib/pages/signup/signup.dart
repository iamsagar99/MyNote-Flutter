import 'package:flutter/material.dart';
import 'package:zippy/widgets/ourContainer.dart';
import 'package:zippy/widgets/signupform.dart';

class OurSignUp extends StatelessWidget {
  const OurSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: ListView(
            padding: EdgeInsets.all(20.0),
            children: <Widget>[
                BackButton(),
                  SizedBox(height: 20,),
              OurSignUpForm()
            ],
          ))
        ],
      ),
    );
  }
}
