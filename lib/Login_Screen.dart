import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:predictas1/Admin/Admin.dart';
import 'package:predictas1/Admin/List_user.dart';

import 'package:predictas1/Dashboard.dart';
import 'package:predictas1/Home_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:predictas1/Home_Screen.dart';
import 'package:predictas1/Profil.dart';
import 'package:predictas1/Register_Screen.dart';
import 'package:predictas1/SearchField.dart';
import '../constants.dart';
import 'Forget_Screen.dart';
import 'Admin/UserModel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _passwordVisible=false;

  @override
  void initState() {
    _passwordVisible = false;
  }
  // form key
  final _formKey = GlobalKey<FormState>();
  double _headerHeight = 250;
  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Entrer un Email valide");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,

        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Entrer un mot de passe");
          }
          if (!regex.hasMatch(value)) {
            return ("Mot de passe Valide (Min. 6 caractères)");
          }
        },

        onSaved: (value) {
          passwordController.text = value!;
        },
        obscureText: !_passwordVisible ,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _passwordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _passwordVisible =!_passwordVisible;
              });
            },
          ),


          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Mot de passe",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.teal,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
           // var emailEditingController;
           // var passwordEditingController;
            signIn(emailController.text, passwordController.text);
          },
          child: Text(
            "Connectez_Vous",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,

        elevation: 0,
      ),


      body: Center(
        child: SingleChildScrollView(
          child: Container(

            color: Colors.white,

            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Insertion Image logo
                    SizedBox(

                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      height: 50,
                      child: Text(
                        "Se connecter",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.teal,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 45),
                    emailField,
                    SizedBox(height: 25),
                    passwordField,
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>oubliscreen()));
                      },
                      child: Text(
                        'Mot de passe oublié?',
                        style: TextStyle(

                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          decorationThickness: 1,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    loginButton,
                    SizedBox(height: 15),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegistrationScreen()));
                            },
                            child: Text(
                              "Créer un nouveau compte",
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),

                          /* child: IconButton(
                  onPressed: () {
                    signInWithGoogle(context);

                    ImageIcon(AssetImage('assets/images/google.png')),
                      icon: Icon(
                        Icons.add_location,
                        color: Colors.black,
                      );},

              ))*/]
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  verfiytype(String uid) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    await firebaseFirestore.collection("users").doc(uid).get().then((value) {
      if (value.exists) {
        UserM user = UserM.fromMap(value.data());

        var type = user.type!;

        if (type == "admin") {
          Fluttertoast.showToast(msg: "Login Successful");
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AdminPage()));
        }
       else{

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => ProfileScreen()));}
      
    }});
  }
  // login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) async {
          verfiytype(uid.user!.uid);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
}