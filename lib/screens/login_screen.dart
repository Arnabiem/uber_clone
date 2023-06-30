import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/main.dart';
import 'package:uber_clone/screens/home_screen.dart';
import 'package:uber_clone/screens/registration_screen.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen="login";
    TextEditingController emailEditingController=TextEditingController();
  TextEditingController passEditingController=TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 50,),
              const Image(
                image: AssetImage('assets/images/logo.png'),
                height: 250,width: 390,
                alignment: Alignment.center,
                ),
                SizedBox(height: 5,),
                const Text(
                  "Login as a Rider",style: TextStyle(fontFamily: "Brand-Bold",fontSize: 25),
                ),
                SizedBox(height: 2,),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children:  [
                       TextField(
                        controller: emailEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            fontSize: 15,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                        style: TextStyle(fontSize: 15),
                      ),
                       TextField(
                        controller: passEditingController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontSize: 15,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 25,),
                      MaterialButton(
                        onPressed: (){
                           if(passEditingController.text.isEmpty){
                            displaytoast("Please enter password ", context);
                          }
                          else if(!emailEditingController.text.contains("@")){
                            displaytoast("Invalid Email", context);
                          }else{
                          loginUser(context);
                          }
                        }, 
                        color: Colors.yellow,
                        textColor: Colors.black,
                       child: Container(
                        height: 50,
                        child: Center(
                          child: Text("Login",style: TextStyle(fontFamily: 'Brand-Bold',fontSize: 18),),
                        ),
                       ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                    ),
                       )
                    ],
                  ),              
                ),
                TextButton(onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.idScreen, (route) => false);
                },
                 child: Text("Don't have an account?Register Here."),
                 )
            ]),
        ),
      ),
    );
  }
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
    void loginUser(BuildContext context) async{
    final User? firebaseUser=(await _firebaseAuth.signInWithEmailAndPassword(
      email: emailEditingController.text, password: passEditingController.text).
      catchError((errMsg){
        displaytoast("Error:"+errMsg, context);
      })).user; 

if(firebaseUser!=null){  
      usersRef.child(firebaseUser.uid).once().then((_) => (DataSnapshot snap){
        if(snap.value!=null){
          Navigator.pushNamedAndRemoveUntil(context, HomeScreen.idScreen, (route) => false);
          displaytoast("Your have logged in successfully", context);
        }else{
          _firebaseAuth.signOut();
          displaytoast("No records found.Please register yourself", context);
        }
      });   

      }else{
        displaytoast("Something went wrong", context);
      }


  }
  
}
displaytoast(String message,BuildContext context){
  Fluttertoast.showToast(msg: message);
}