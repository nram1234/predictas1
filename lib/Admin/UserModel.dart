import 'package:cloud_firestore/cloud_firestore.dart';
class UserM {
  String? uid;
  String? nom;
  String? prenom;
  String? telephone;
  String? email;
  String? type;

  UserM({this.uid,this.nom,this.prenom,this.telephone,this.email,this.type });

  factory UserM.fromMap(map){
    return UserM(
      uid: map['uid'],
      nom: map['nom'],
      prenom: map['prenom'],
      telephone: map['telephone'],
      email: map['email'],
      type: map['type'],

    );

  }
  Map<String,dynamic> toMap(){
    return{
      'uid':uid,
      'nom':nom,
      'prenom':prenom,
      'telephone':telephone,
      'email':email,
      'type':type,

    };
  }

}