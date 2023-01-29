import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zippy/pages/login/login.dart';
import 'package:zippy/states/currentUser.dart';
import 'package:zippy/widgets/ourContainer.dart';

class OurSignUpForm extends StatefulWidget {
  const OurSignUpForm({Key? key}) : super(key: key);

  @override
  State<OurSignUpForm> createState() => _OurSignUpFormState();
}

class _OurSignUpFormState extends State<OurSignUpForm> {

  TextEditingController _fulNameController  = TextEditingController();
  TextEditingController _emailController  = TextEditingController();
  TextEditingController _passwordController  = TextEditingController();
  TextEditingController _confirmPasswordController  = TextEditingController();

  void _signUpUser(String email,String password,String fulName,BuildContext context) async{
    CurrentUser _currentuser = Provider.of<CurrentUser>(context,listen:false);
    try{
      String _returnString = await _currentuser.SignUpUser(email,password,fulName);
      if(_returnString == "success"){
        Navigator.pop(context);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_returnString),
              duration:Duration(seconds: 2) ,)
        );
      }
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OurContainer(
      child: Column(
        children: <Widget>[

          Padding(padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
            child: Text("Sign Up",style: TextStyle(
              color:Colors.black26,
              fontSize: 25.0,
              fontWeight:  FontWeight.bold,
            ),
            ),
          ),
          TextFormField(controller: _fulNameController,decoration: InputDecoration(prefixIcon: Icon(Icons.person), hintText: "Full Name"),),
          SizedBox(height: 20.0),
          TextFormField(controller: _emailController,decoration: InputDecoration(prefixIcon: Icon(Icons.alternate_email), hintText: "Email"),),
          SizedBox(height: 20.0),
          TextFormField(controller:_passwordController,decoration: InputDecoration(prefixIcon: Icon(Icons.lock_outline), hintText: "Password"),obscureText: true,),
          SizedBox(height: 20.0),
          TextFormField(controller:_confirmPasswordController,decoration: InputDecoration(prefixIcon: Icon(Icons.lock_outline), hintText: "Confirm Password"), obscureText: true,),
          SizedBox(height: 20.0),
          ElevatedButton(onPressed: () {
            if(_passwordController.text == _confirmPasswordController.text){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("password match"),
                    duration:Duration(seconds: 2) ,)
              );
              _signUpUser(_emailController.text,_passwordController.text,_fulNameController.text, context);
            }else{
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Plesase use the valid email and  paassword>6"),
                  duration:Duration(seconds: 2) ,)
              );
            }
          }, child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 100),
            child: Text("Register",style: TextStyle(color: Colors.white, fontSize: 15.0,fontWeight: FontWeight.bold),),
          )),
          TextButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OurLogin()),);
          }, child: Text("Already have an account? Login Here!")
          )

        ],
      ),
    );
  }
}
