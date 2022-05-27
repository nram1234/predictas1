

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:predictas1/Admin/List_user.dart';
import 'package:predictas1/Login_Screen.dart';

import 'UserModel.dart';



class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  _signOut() async {
    await _firebaseAuth.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(

          appBar: PreferredSize(

            preferredSize: Size.fromHeight(90.0),
            // here the desired height
            child: AppBar(
              backgroundColor: Colors.teal,
              title: Text("Espace administrateur"),


                   actions: [
                 ElevatedButton(
            style: ElevatedButton.styleFrom(
            primary: Colors.teal,
                ),

               clipBehavior: Clip.hardEdge,
               child: Center(
                 child:  Icon(
                 Icons.logout,

                 color: Colors.white),
               ),
               onPressed: () async {
                 await _signOut();
                 if (_firebaseAuth.currentUser == null) {
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => LoginScreen()),
                   );
                 }
               }

               ),


         ],

            ),

          ),

          body:

          ConditionalBuilder(
            condition: users.isNotEmpty,
            builder: (context) => ListView.builder(
              itemBuilder: (context, index) {

                var type;
                return Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,




                    children: [
                      CircleAvatar(
                        child: Center(
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AdminPage()),
                                  );
                                },
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ))),
                        //foregroundImage:NetworkImage(widget.picture)

                      ),
                    SizedBox(height: 60),
                      Column(
                        children: [

                          Divider(color: Colors.teal),
                          Text("${users[index].nom!} ${users[index].prenom!}"),

                          Text(users[index].email!),

                        ],

                ),

                      MaterialButton(
                        onPressed: (){
                          deleteUser(users[index].uid!);
                        },

                        child: const Icon(Icons.delete,color: Colors.black,),



                        ),



                    ],

                  ),


                );
              },
              itemCount: users.length,
            ),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ));
  }
}
