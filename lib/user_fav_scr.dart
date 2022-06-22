import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'networking/Advert_json.dart';
class UserFavScr extends StatefulWidget {
  const UserFavScr({Key? key}) : super(key: key);

  @override
  _UserFavScrState createState() => _UserFavScrState();
}

class _UserFavScrState extends State<UserFavScr> {

  CollectionReference fave=FirebaseFirestore.instance
      .collection('adsFav');
  QuerySnapshot? data;
  @override
  void initState()  {
    super.initState();
    getdata();
  }
getdata()async{
 // QuerySnapshot querySnapshot=await
  fave.get().then((value) {
    print(value.docs.length);
  });
}
  @override
  Widget build(BuildContext context) {
Size size=MediaQuery.of(context).size;
    return Scaffold(appBar: AppBar(title: const Text("fav"),centerTitle: true,)
      ,body:
      StreamBuilder<QuerySnapshot>(
        stream: fave.doc(FirebaseAuth.instance.currentUser?.uid).collection("userfav").get().asStream(),
        builder: (context, snapshot) {
          if(snapshot.hasData){

            return ListView.builder(itemCount: snapshot.data?.docs.length,itemBuilder: (context,pos){
              print("ppppppppppppppppppppppppppppppppppppp");
              print(snapshot.data?.docs[pos].data());
              Map<String, dynamic> data = snapshot.data?.docs[pos] .data()as Map<String, dynamic>;
           //  Adverts? adverts=Adverts.fromJson;
             // print(snapshot.data?.docs[pos].data());
              data.forEach((key, value) {
                print("$key       =>     $value");
              });
              //return Text(data["description"].toString() );
              // Adverts? adverts=     snapshot.data?.docs[pos].data() as Adverts?;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(
                            0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  height: size.height * .26,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: size.height * .2,
                          child:  data["photo"]
                             !=
                              null
                              ? Image.network(
                            data["photo"],
                            fit: BoxFit.fill,
                          )
                              : Image.asset("assets/images/no-image.jpeg"),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  data["title"],
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                data["price"]
                                    .toString()
                                // numberFormat.format(adverts.price) +
                                //     ' ' +
                                //     SettingsApp.moneySymbol,
                                ,
                                style: const TextStyle(
                                    color: Colors.black, //framColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.grey,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: size.width * .28,
                                    child: Text(


                                      "${  data["town"] ["name"]?? ""}, ${data["city"] ["name"]?? ""}",
                                      softWrap: true,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
GestureDetector(onTap: (){
  fave.doc(snapshot.data?.docs[pos].id).delete().then((value) {
    setState(() {

    });
  });

},child: Icon(Icons.delete))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );  return Text("pos   $pos");
            });
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
          }

      ),);
    
  }
}
