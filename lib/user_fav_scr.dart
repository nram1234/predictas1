import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class UserFavScr extends StatefulWidget {
  const UserFavScr({Key? key}) : super(key: key);

  @override
  _UserFavScrState createState() => _UserFavScrState();
}

class _UserFavScrState extends State<UserFavScr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("fav"),centerTitle: true,)
      ,body:
      StreamBuilder<Object>(
        stream: FirebaseFirestore.instance
            .collection('adsFav').snapshots(),
        builder: (context, snapshot) {

          return snapshot.hasData?ListView.builder(itemCount: 100,itemBuilder: (context,pos){
            return Text("pos   $pos");
          }):const Center(child: CircularProgressIndicator(),);
        }
      ),);
    
  }
}
