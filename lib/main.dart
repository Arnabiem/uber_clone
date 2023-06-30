import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/screens/home_screen.dart';
import 'package:uber_clone/screens/login_screen.dart';
import 'package:uber_clone/screens/registration_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
DatabaseReference usersRef=FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Uber Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // fontFamily: "Signatra",       
        primarySwatch: Colors.blue,
      ),
      // home:  RegistrationScreen(),
      initialRoute: LoginScreen.idScreen,
      routes: {
        RegistrationScreen.idScreen:(context)=> RegistrationScreen(),
        LoginScreen.idScreen:(context)=> LoginScreen(),
        HomeScreen.idScreen:(context)=> HomeScreen(),

      },
    );
  }
}
