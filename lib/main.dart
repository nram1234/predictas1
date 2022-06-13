import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:predictas1/Admin/Admin.dart';
import 'package:predictas1/Admin/List_user.dart';
import 'package:predictas1/Login_Screen.dart';
import 'package:predictas1/Profil.dart';
import 'package:predictas1/SearchField.dart';
import 'package:predictas1/myhome.dart';
import 'package:predictas1/screens/SplacheScreen.dart';
import 'package:searchfield/searchfield.dart';

import 'user_fav_scr.dart';



void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  getAllUsers();
  print( "FirebaseAuth.instance.currentUser => ${FirebaseAuth.instance.currentUser}");
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'predictat',
      theme: ThemeData(
        //primarySwatch: Colors.blue,
      ),
      home: SearchScreen (),//UserFavScr()//
    );
  }
}
