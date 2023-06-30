import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/main.dart';
import 'package:uber_clone/screens/home_screen.dart';
import 'package:uber_clone/screens/login_screen.dart';

class RegistrationScreen extends StatelessWidget {
  static const String idScreen="signup";
  TextEditingController nameEditingController=TextEditingController();
  TextEditingController emailEditingController=TextEditingController();
  TextEditingController passEditingController=TextEditingController();
  TextEditingController phoneEditingController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 25,),
              const Image(
                image: AssetImage('assets/images/logo.png'),
                height: 250,width: 390,
                alignment: Alignment.center,
                ),
                SizedBox(height: 5,),
                const Text(
                  "Register as a Rider",
                  style: TextStyle(fontFamily: "Brand-Bold",fontSize: 25),
                ),
                SizedBox(height: 2,),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children:  [
                       TextField(
                        controller:nameEditingController ,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: "Name",
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
                        controller: phoneEditingController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Phone No.",
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
                          if(nameEditingController.text.length<2){
                            displaytoast("Name should be atleast 2 characters", context);
                          }
                          else if(phoneEditingController.text.isEmpty){
                            displaytoast("Phone no.is mandatory ", context);
                          }
                          else if(passEditingController.text.length<6){
                            displaytoast("Password should be atleast 6 characters", context);
                          }
                          else if(!emailEditingController.text.contains("@")){
                            displaytoast("Invalid Email", context);
                          }else{
                          registerNewUser(context);
                          }
                        }, 
                        color: Colors.yellow,
                        textColor: Colors.black,
                       child: Container(
                        height: 50,
                        child: Center(
                          child: Text("Register",
                          style: TextStyle(fontFamily: 'Brand-Bold',fontSize: 18),),
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
          Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);

                },
                 child: Text("Already have an account? Login Here."),
                 )
            ]),
        ),
      ),
    );
  }
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  void registerNewUser(BuildContext context) async{
    final User? firebaseUser=(await _firebaseAuth.createUserWithEmailAndPassword(
      email: emailEditingController.text, password: passEditingController.text).
      catchError((errMsg){
        displaytoast("Error:"+errMsg, context);
      })).user; 
      
      if(firebaseUser!=null){        
        Map userDataMap={
          'name':nameEditingController.text.trim(),
          'phone_no':phoneEditingController.text.trim(),
          'email':emailEditingController.text.trim(),
        };
      usersRef.child(firebaseUser.uid).set(userDataMap);
      displaytoast("Your account has been created successfully", context);
      Navigator.pushNamedAndRemoveUntil(context, HomeScreen.idScreen, (route) => false);

      }else{
        displaytoast("New user account has not been created", context);
      }
  }
}

displaytoast(String message,BuildContext context){
  Fluttertoast.showToast(msg: message);
}

