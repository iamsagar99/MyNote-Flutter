import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zippy/pages/signup/signup.dart';
import 'package:zippy/states/currentUser.dart';
import 'package:zippy/widgets/ourContainer.dart';
import 'package:zippy/pages/home.dart';
import 'package:zippy/pages/splash_screen.dart';
import 'package:zippy/providers/bookData.dart';
import 'package:google_fonts/google_fonts.dart';
class OurLoginForm extends StatefulWidget {
  const OurLoginForm({Key? key}) : super(key: key);

  @override
  State<OurLoginForm> createState() => _OurLoginFormState();
}

class _OurLoginFormState extends State<OurLoginForm> {

  TextEditingController _emailController  = TextEditingController();
  TextEditingController _passwordController  = TextEditingController();

  void _loginUser(String email,String password,BuildContext context) async{
    CurrentUser _currentuser = Provider.of<CurrentUser>(context,listen:false);

    try{
      String _returnString = await _currentuser.LoginUserWithEmail(email, password);

      if(_returnString == "success"){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>ChangeNotifierProvider(
            create: ((context) => BookData()),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                textTheme: GoogleFonts.poppinsTextTheme(
                  Theme.of(context).textTheme,
                ),
              ),
              routes: {
                Home.id: (context) => const Home(),
                Splash.id: (ctx) => const Splash(),
              },
              initialRoute: Splash.id,
            ),
          ),
          )
        );
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Invalid Credentials"+_returnString),
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
          child: Text("Log In",style: TextStyle(
              color:Colors.black26,
              fontSize: 25.0,
              fontWeight:  FontWeight.bold,
          ),
          ),
          ),
          TextFormField(controller: _emailController,decoration: InputDecoration(prefixIcon: Icon(Icons.alternate_email), hintText: "Email"),),
          SizedBox(height: 20.0),
          TextFormField(controller: _passwordController,decoration: InputDecoration(prefixIcon: Icon(Icons.lock_outline), hintText: "Password"),obscureText: true,),
          SizedBox(height: 20.0),
          ElevatedButton(onPressed: () {

            _loginUser(_emailController.text,_passwordController.text,context);
          }, child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 100),
          child: Text("Login",style: TextStyle(color: Colors.white, fontSize: 20.0,fontWeight: FontWeight.bold),),
          )),
          TextButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OurSignUp()),);
          }, child: Text("Don't have an account? Sign Up here")
          ),
        ],
      ),
    );
  }
}
