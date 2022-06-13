import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Dashboard.dart';

import 'Login_Screen.dart';
import 'Admin/UserModel.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();




}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // string for displaying the error Message
  String? errorMessage;


  // our form key

  final _formKey = GlobalKey<FormState>();
  // editing Controller
  late TextEditingController nomEditingController = new TextEditingController();
  late TextEditingController prenomEditingController = new TextEditingController();
  late     TextEditingController telephoneEditingController = new TextEditingController();
late  TextEditingController  emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  bool _passwordVisible=false;
  get controller => null;

  UserM currentuser=UserM();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).
    get().then(( DocumentSnapshot<Map<String, dynamic>> value) {
      currentuser = UserM.fromMap(value.data());
      nomEditingController = new TextEditingController(text:currentuser.nom);
      prenomEditingController = new TextEditingController(text:currentuser.prenom);
       telephoneEditingController = new TextEditingController(text:currentuser.telephone);
       emailEditingController = new TextEditingController(text:currentuser.email);

    });}


  @override
  Widget build(BuildContext context) {
    //nom field
    final nomField = TextFormField(
        autofocus: false,
        controller: nomEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Le champ ne doit pas être vide");
          }
          if (!regex.hasMatch(value)) {
            return ("Nom valide (Min. 3 caractère)");
          }
          return null;
        },
        onSaved: (value) {
          nomEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration:  InputDecoration(
          prefixIcon: Icon(Icons.edit),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Nom",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    //prénom field




    final prenomField = TextFormField(
        autofocus: false,
        controller: prenomEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Le champ ne doit pas être vide");
          }
          if (!regex.hasMatch(value)) {
            return ("Prénom valide (Min. 3 caractère)");
          }
          return null;
        },
        onSaved: (value) {
          prenomEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.edit),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Prénom",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    //telephone field
    final telephoneField = TextFormField(
        autofocus: false,
        controller: telephoneEditingController,
        keyboardType: TextInputType.phone,
        validator: (value) {
          return null;
        },
        onSaved: (value) {
          telephoneEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.edit),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Telephone",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {

          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value!)) {
            return ("Entrer un valide Email");
          }
          return null;
        },
        onSaved: (value) {
          emailEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.edit),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: !_passwordVisible,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');

        if (!regex.hasMatch(value!)) {
          return ("Entrer un valide mot de passe(Min. 6 caractères )");
        }
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },




      textInputAction: TextInputAction.done,

      decoration: InputDecoration(
          prefixIcon: Icon(Icons.edit),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: "Mot de passe",

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
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
          )
      ),
    );
    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: !_passwordVisible,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Les mots de passe que vous avez entrés ne sont pas identiques. ";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },


        textInputAction: TextInputAction.done,

        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            labelText: "confirmer mot de passe",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
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
            )
        )
    );


    //signup button
    final ModifyButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.teal,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            postDetailsToFirestore();
           // Update(emailEditingController.text, passwordEditingController.text);
            _auth.currentUser!.updateEmail(emailEditingController.text) ;       },
          child: Text(
            "Modifier",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    final DeleteButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.teal,
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            DeleteData();

          },
          child: Text(
            "Supprimer",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
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
                    SizedBox(
                        height: 30,
                        child:  Text(
                          "Profile",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30, color: Colors.teal, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: 115,
                      width: 115,
                      child: Stack(
                        fit: StackFit.expand,
                        clipBehavior: Clip.none,
                        children: [

                          CircleAvatar(
                            radius: 16.0,
                            child: ClipRRect(
                              child: Image.asset('assets/image.png'),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),

                          Positioned(
                              right: -16,
                              bottom: 0,
                              child: SizedBox(
                                height: 46,
                                width: 46,
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: BorderSide(color: Colors.white),
                                    ),
                                    primary: Colors.white,
                                    backgroundColor: Color(0xFFF5F6F9),
                                  ),
                                  child:
                                  IconButton(
                                    icon: Icon(Icons.linked_camera_rounded),
                                    onPressed: () {},

                                  ),
                                ),
                              )
                          ), ],
                      ),

                    ),
                    SizedBox(height: 45),
                    nomField,
                    SizedBox(height: 20),
                    prenomField,
                    SizedBox(height: 20),
                    telephoneField,
                    SizedBox(height: 20),
                    emailField,
                    SizedBox(height: 20),
                    passwordField,
                    SizedBox(height: 20),
                    confirmPasswordField,
                    SizedBox(height: 20),
                    ModifyButton,
                    SizedBox(height: 15),
                    SizedBox(height: 15),
                    DeleteButton,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void Update(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Email non valide.";
            break;
          case "wrong-password":
            errorMessage = "Mot de passe incorrecte.";
            break;
          case "user-not-found":
            errorMessage = "Utilisateur unexistant.";
            break;
          case "user-disabled":
            errorMessage = "Utilisateur non trouvé.";
            break;
          case "too-many-requests":
            errorMessage = "Erreur";
            break;
          case "operation-not-allowed":
            errorMessage = "Connexion échoué.";
            break;
          default:
            errorMessage = "Erreur.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
  postDetailsToFirestore() async {
    //
    // calling our firestore
    // calling our user model
    // sending these values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserM userModel = UserM();
    // writing all the values
    userModel.email = emailEditingController.text;
    userModel.uid = user?.uid;
    userModel.nom = nomEditingController.text;
    userModel.prenom = prenomEditingController.text;
    userModel.telephone=telephoneEditingController.text;
    userModel.type=currentuser.type;        print (user?.uid);
    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Compte modifié avec succès ");
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
  }
  DeleteData(){
    Widget okButton = ElevatedButton(
      child: Text("Yes"),
      onPressed: () {
        setState(() {
          _auth.currentUser?.delete();
          //var key;

          DeleteFirestore();
          Navigator.of(context).pop();
        });
      },
    );
    Widget no = ElevatedButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Delete Data"),
      content: Text("Do you want to delete?"),
      actions: [
        okButton,
        no,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  DeleteFirestore() async {
    //
    // calling our firestore
    // calling our user model
    // sending these values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserM userModel = UserM();
    // writing all the values
    userModel.email = emailEditingController.text;
    userModel.uid = user?.uid;
    userModel.nom = nomEditingController.text;
    userModel.prenom = prenomEditingController.text;
    userModel.telephone=telephoneEditingController.text;
    userModel.type=currentuser.type;
    print (user?.uid);
    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .delete();
    Fluttertoast.showToast(msg: "Compte supprimé avec succès ");
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
  }
}

