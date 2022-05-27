import  'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:predictas1/Login_Screen.dart';
import 'package:predictas1/SearchField.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 4),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => SearchScreen())));



    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(


        decoration: new BoxDecoration(color: Colors.white),

        child: new Center(
          child: SizedBox(
            width: _size.width * 0.9,
            child: Image.asset(

              "assets/images/maison.png",
              fit: BoxFit.fill,
            ),

          ),
        ),


      ),
    );
  }
}