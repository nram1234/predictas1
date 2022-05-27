import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:predictas1/button.dart';
import '/constants.dart';
import 'package:predictas1/Home_Screen.dart';
import 'Login_Screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
class oubliscreen extends StatefulWidget {
  const oubliscreen({Key? key}) : super(key: key);

  @override
  _oubliscreenState createState() => _oubliscreenState();
}

class _oubliscreenState extends State<oubliscreen> {
  @override
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Widget Title = Container(
    padding: EdgeInsets.symmetric(horizontal: 20,),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Mot de passe ",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
            Container(width: 5),
            const Text(
              "oublié",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(
              width: 70.0,
              child: Center(
                child: Container(
                  margin: new EdgeInsetsDirectional.only(
                      start: 10.0, end: 10.0),
                  height: 1.0,
                  color: Colors.black,
                ),
              ),
            ),


          ],
        )
      ],
    ),
  );
  Widget back = Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [

          Container(height: 615, width: 300,),
          Positioned(top: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              height: 510, width: 290,
              margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 35),
            ),
          ),
        ],

      )
  );

  Widget text(BuildContext context) {
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: const Text("Mot de passe oublié?",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text("Saisissez l'adresse e-mail associée",
                  style: TextStyle(fontSize: 16)),
              Text("avec le compte", style: TextStyle(fontSize: 16)),
              SizedBox(height: 5),
              Text("Nous vous enverrons un lien pour réinitialiser",
                  style: TextStyle(color: Colors.black54)),
              Text(" Votre mot de passe", style: TextStyle(color: Colors.black54)),
              SizedBox(height: 150),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(12)

                ),
                child: Container(
                    padding: EdgeInsets.all(10),
                    constraints: const BoxConstraints(
                        minWidth: 80, minHeight: 40, maxWidth: 260),
                    child: Row(
                      children: [
                        Icon(Icons.email),
                        SizedBox(width: 20),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("EMAIL",
                                style: TextStyle(
                                    color: Colors.black
                                ),
                              ),
                              SizedBox(
                                width: 180, height: 50,
                                child: TextFormField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                  ),

                                ),
                              )
                            ]
                        ),
                      ],
                    )
                ),
              ),
              SizedBox(height: 13),
              Container(
                // width: 120,
                padding: EdgeInsets.only(left: 30, top: 7, right: 7, bottom: 7),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.teal, Colors.teal]),
                    borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(40), left: Radius.circular(40))
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Envoyer", style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),),
                      Container(width: 15),
                      Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.teal
                        ),
                        child: IconButton(onPressed: () async {
                          resetPassword();
                        },
                            icon: Icon(Icons.arrow_forward_rounded),
                            iconSize: 25,
                            color: Colors.black), width: 40, height: 40,)
                    ]
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Retour ",
                    style: TextStyle(
                        fontSize: 13
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => LoginScreen()));
                      });
                    },
                    child: Container(
                        child: const Text("Connectez",
                          style: TextStyle(
                              color: Color(0xFF267D43)
                          ),
                        )
                    ),
                  ),
                ],
              ),
              SizedBox(height: 80, width: 20),
            ]
        )
    );
  }


  @override
  Widget build(BuildContext context) {

    return Form(
        key: _formKey,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: 'Balsamiq_Sans'),
            home: Scaffold(

                body: Container(
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 15.0),
                    child: ListView(
                        children: [
                          Title,
                          Stack(
                              alignment: Alignment.center,
                              children: [
                                back,
                                text(context),

                              ]
                          )
                        ]
                    ),
                  ),
                )
            )
        ));
  }

  resetPassword() async {
    String email = _emailController.text.toString();
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    }
    catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }




// @override
// Future<void> resetPassword(String email) async {
// try {
//
// await _firebaseAuth.sendPasswordResetEmail(email: email);
// Fluttertoast.showToast(msg: "Kindly reset your password using the link sent on your mail");
// }
// catch(e){
// Fluttertoast.showToast(msg: e.toString());
// }
}