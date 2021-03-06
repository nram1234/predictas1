import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:predictas1/settings/setting.dart';
import 'package:intl/intl.dart';
import 'package:predictas1/networking/Advert_json.dart';
import 'package:predictas1/user_fav_scr.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'Login_Screen.dart';
import 'Profil.dart';
import 'Register_Screen.dart';
import 'n/all_dro_stat.dart';

class MyHome extends StatefulWidget {
  AdvertsJson? adverts;

  MyHome(this.adverts);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List<List<dynamic>> csvTable = [];
  List<int> ids = [];

  List querySnapshot = [];
  Map<int, dynamic> de = {};
  List<Price> price = [];
  Map<String,List<Price>>dataToMap={};

  List<Price> price2 = [];
  Map<String,List<Price>>dataToMap2={};


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.teal,
          actions: [
            IconButton(icon: Icon(Icons.favorite_border, color: Colors.white),


                onPressed: () async {
                  if (FirebaseAuth
                      .instance.currentUser !=
                      null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>UserFavScr()),
                    );
                  }else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>LoginScreen()),
                    );
                  }

                }
            )
            , IconButton(icon: Icon(Icons.account_box, color: Colors.white),


                onPressed: () async {
                  if (FirebaseAuth
                      .instance.currentUser !=
                      null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>ProfileScreen()),
                    );
                  }else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>LoginScreen()),
                    );
                  }

                }
            )
          ]


      ),

      body: Column(
        children: [
          Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: SfCartesianChart(
                  series: <ChartSeries>[
                    // LineSeries<Price, int>(
                    //     dataSource: price,
                    //     xValueMapper: (Price p, _) => p.year,
                    //     yValueMapper: (Price p, _) => p.p,
                    //     color: Colors.greenAccent,
                    //     enableTooltip: true,
                    //     markerSettings: MarkerSettings(
                    //        // isVisible: true,
                    //         height: 1,
                    //         width: 1,
                    //         shape: DataMarkerType.circle,
                    //         borderWidth: 3,
                    //         borderColor: Colors.black),
                    //     dataLabelSettings: DataLabelSettings(
                    //    //   isVisible: true,
                    //     )),


                    LineSeries<Price, double>(sortingOrder: SortingOrder.ascending,
                        dataSource: price,
                        yValueMapper: (Price p, _) => p.year,
                        xValueMapper: (Price p, _) => p.p,
                        color: Colors.blueAccent,
                        //    enableTooltip: true,
                        markerSettings: MarkerSettings(
                          //    isVisible: true,
                            height: 1,
                            width: 1,
                            // shape: DataMarkerType.circle,
                            //  borderWidth: 3,
                            borderColor: Colors.black),
                        dataLabelSettings: DataLabelSettings(
                          //       isVisible: true,
                        )),


                    LineSeries<Price, double>(sortingOrder: SortingOrder.ascending,
                        dataSource: price2,
                        yValueMapper: (Price p, _) => p.year,
                        xValueMapper: (Price p, _) => p.p,
                        color: Colors.tealAccent,
                        //    enableTooltip: true,
                        markerSettings: MarkerSettings(
                          //    isVisible: true,
                            height: 1,
                            width: 1,
                            // shape: DataMarkerType.circle,
                            //  borderWidth: 3,
                            borderColor: Colors.black),
                        dataLabelSettings: DataLabelSettings(
                          //       isVisible: true,
                        )),

                  ]
                  //,primaryXAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift)
                  ,

                  isTransposed: true,
                  crosshairBehavior: CrosshairBehavior(enable: true),zoomPanBehavior:  ZoomPanBehavior(
                // Enables pinch zooming
                  enablePinching: true, enableDoubleTapZooming: true,enablePanning: true,zoomMode: ZoomMode.xy,enableSelectionZooming: true
              ),primaryXAxis: NumericAxis(title: AxisTitle(text: "price"),
                  numberFormat:
                  NumberFormat.simpleCurrency(decimalDigits: 0)), primaryYAxis:  NumericAxis( interval: 1,minimum: 2018,maximum: 2025,
                  title: AxisTitle(text: "year")),
                  title:ChartTitle(text: "Prediction de prixm2 au futur en france")
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(child: Column(children: [
              Row(children: [Text("prixm2 au futur "),SizedBox(width: 8,),Container(height: 5,width: 20,color: Colors.blueAccent,)],),
              Row(children: [Text("prixm2 au passer"),SizedBox(width: 8,),Container(height: 5,width: 20,color: Colors.greenAccent,)],),
            ],)),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: widget.adverts?.eEmbedded?.adverts?.length,
                itemBuilder: (context, pos) {
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
                              child: widget.adverts?.eEmbedded?.adverts?[pos]
                                  .photo !=
                                  null
                                  ? Image.network(
                                widget.adverts?.eEmbedded?.adverts?[pos]
                                    .photo ??
                                    "",
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
                                      widget.adverts?.eEmbedded?.adverts?[pos]
                                          .title ??
                                          "",
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
                                    widget.adverts?.eEmbedded?.adverts?[pos]
                                        .price
                                        .toString() ??
                                        ""
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
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.grey,
                                        size: 18,
                                      ),
                                      Container(
                                        width: size.width * .28,
                                        child: Text(
                                          "${widget.adverts?.eEmbedded?.adverts?[pos].region?.name ?? ""}, ${widget.adverts?.eEmbedded?.adverts?[pos].city?.name ?? ""}",
                                          softWrap: true,
                                          style: TextStyle(
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
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // print("annonce ajout??");
                                          // isFavorite != isFavorite;
                                        },
                                        child: GestureDetector(
                                          onTap: () {
                                            if (FirebaseAuth
                                                .instance.currentUser ==
                                                null) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                    const LoginScreen()),
                                              );
                                            } else {
                                              //  DatabaseReference ref = FirebaseDatabase.instance.ref("users/f");
                                              //   final newPostKey =
                                              //       FirebaseDatabase.instance.ref().child('posts').set("ooooooooooooooooooo").then((value) {
                                              //         print("object");
                                              //       });

                                              print(widget.adverts?.eEmbedded
                                                  ?.adverts?[pos]
                                                  .toJson());
                                              Map<String, dynamic>? data =
                                              widget.adverts?.eEmbedded
                                                  ?.adverts?[pos]
                                                  .toJson();
                                              print(ids.contains(widget
                                                  .adverts
                                                  ?.eEmbedded
                                                  ?.adverts?[pos]
                                                  .id));
                                              print(widget.adverts?.eEmbedded
                                                  ?.adverts?[pos].id);
                                              if (ids.contains(widget
                                                  .adverts
                                                  ?.eEmbedded
                                                  ?.adverts?[pos]
                                                  .id)) {
                                                //  ids.remove(widget.adverts?.eEmbedded?.adverts?[pos].id);

//
// print(doc);
                                                FirebaseFirestore.instance
                                                    .collection('fav').doc(FirebaseAuth.instance.currentUser?.uid).collection("userfav")
                                                    .doc(de[widget
                                                    .adverts
                                                    ?.eEmbedded
                                                    ?.adverts?[pos]
                                                    .id])
                                                    .delete();
                                                print("i delete data");
                                                ids.remove(widget
                                                    .adverts
                                                    ?.eEmbedded
                                                    ?.adverts?[pos]
                                                    .id);
                                                setState(() {});
                                                getD();
                                              } else {
                                                FirebaseFirestore.instance
                                                    .collection('fav').doc(FirebaseAuth.instance.currentUser?.uid).collection("userfav")
                                                    .add({
                                                  "id": widget
                                                      .adverts
                                                      ?.eEmbedded
                                                      ?.adverts?[pos]
                                                      .id


                                                }).then((value) {
                                                  print("i add data");
                                                  getD();
                                                });
                                                Map<String, dynamic> d=widget
                                                    .adverts
                                                    ?.eEmbedded
                                                    ?.adverts?[pos].toJson() as Map<String, dynamic>;

                                                FirebaseFirestore.instance
                                                    .collection('adsFav').doc(FirebaseAuth.instance.currentUser?.uid).collection("userfav")
                                                    .add( d).then((value) {
                                                  print("i add data");
                                                  getD();
                                                });
                                              }

                                              //   getD();

                                              // .collection("cities")
                                              // .doc("LA")
                                              // .set(city)
                                              // .onError((e, _) => print("Error writing document: $e"));

                                            }
                                            Fluttertoast.showToast(msg: "Favoris ajouter avec succ??s ");
                                          },

                                          child: Icon(
                                            //  widget.adverts?.eEmbedded?.adverts?[pos].region.

                                            Icons.favorite,
                                            color: ids.contains(widget
                                                .adverts
                                                ?.eEmbedded
                                                ?.adverts?[pos]
                                                .id)
                                                ? Colors.pink
                                                : Colors.grey,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );

                  // return Container(
                  //   height: 100,
                  //   width: double.infinity,
                  //   child:Column(
                  //     children: [
                  //       Text(widget.adverts?.eEmbedded?.adverts?[pos].title??" "),
                  //       Image.network(widget.adverts?.eEmbedded?.adverts?[pos].photo??"")
                  //     ],
                  //   )
                  // );
                }),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadAsset();
    loadAsset2();
    getD();
  }

  getD() {
    FirebaseFirestore.instance.collection('fav').get().then((value) {
      querySnapshot = value.docs;
      widget.adverts?.eEmbedded?.adverts?.forEach((element) {
        print(element.id);
      });
      print("*" * 100);
      for (int i = 0; i < value.docs.length; i++) {
        if (value.docs[i].data()["id"] != null) {
          de[value.docs[i].data()["id"]] = value.docs[i].id;
          ids.add(value.docs[i].data()["id"]);
        }
      }
      de.forEach((key, value) {
        print("$key      =>         $value");
      });
      setState(() {});
    });
  }

  loadAsset() async {
    final csvData = await rootBundle.loadString("assets/PredictPrice.csv");
    csvTable = const CsvToListConverter().convert(csvData);
    print("csvTable.length    => ${csvTable.length}");
//     print(csvData);
    print(csvTable.length);
    print(csvTable.first); //csvTable.length













    for (int i = 1; i < csvTable.length; i++) {

      dataToMap[csvTable[i][5]]=[];


    }



    for (int i = 1; i < csvTable.length; i++) {
      // print("*"*100);
      // print("csvTable[i][6]  =>${csvTable[i][6]}");
      // print("csvTable[i][4]   =>${csvTable[i][5]}");
      // print("csvTable[i][5]   => ${csvTable[i][7]}");
      //
      //
      // print("9999999999999999999999999");
      // print(AllDrob.city?.name);
      // print(AllDrob.town?.name);
      // print(AllDrob.region?.name);
      // print("*"*100);


      if(dataToMap[csvTable[i][5]]!=null){
        print(   dataToMap[csvTable[i][5]]!.length>0);
        print(   dataToMap[csvTable[i][5]]!.length>0);
        dataToMap[csvTable[i][5]]!.add(Price(
          year: csvTable[i][7],
          p: double.parse(csvTable[i][8].toString()),
        ));
      }

      if(csvTable[i][7].toString().toLowerCase().contains(AllDrob.region?.name?.toLowerCase()??"")&&csvTable[i][6].toString().toLowerCase().contains(AllDrob.city
          ?.name?.toLowerCase()??"")&&csvTable[i][5].toString().toLowerCase().contains(AllDrob.town?.name?.toLowerCase()??"")){

        String? a=AllDrob.region?.name;
        print(csvTable.contains(AllDrob.region?.name));
        print(csvTable);
        print(csvTable.contains(a??""));
        print(csvTable[i][4]);
        print(csvTable[i][3]);
        print(csvTable[i][5]);
        price.add(Price(
          year: csvTable[i][7],
          p: double.parse(csvTable[i][8].toString()),
        ));
        // price.add(Price(year: 100+i.toDouble(), newPrice: i*10, oldPrice: i*5));

      }

    }

    price=dataToMap[AllDrob.city?.name]??[];
    Map<int,Price>a={ };
    price.forEach((element) {
      a[element.year]=element;
    });
    price=   a.entries.map((e) => e.value).toList();

    print("dataToMap  =>${dataToMap.length}");
    print("city?.name  =>${AllDrob.city?.name}");
    print("price.length  =>${price.length}");
    price. forEach((element) {
      print(element.year);
      print(element.p);
    });
  }
  loadAsset2() async {
    final csvData = await rootBundle.loadString("assets/OldPrice.csv");
    csvTable = const CsvToListConverter().convert(csvData);
    print("csvTable.length    => ${csvTable.length}");
//     print(csvData);
    print(csvTable.length);
    print(csvTable.first); //csvTable.length













    for (int i = 1; i < csvTable.length; i++) {

      dataToMap2[csvTable[i][6]]=[];


    }


//?????? ?????????? ???????????? ?????????????? ?????????????? ???? ????????????????
    for (int i = 1; i < csvTable.length; i++) {
      // print("*"*100);
      // print("csvTable[i][6]  =>${csvTable[i][6]}");
      // print("csvTable[i][4]   =>${csvTable[i][5]}");
      // print("csvTable[i][5]   => ${csvTable[i][7]}");
      //
      //
      // print("9999999999999999999999999");
      // print(AllDrob.city?.name);
      // print(AllDrob.town?.name);
      // print(AllDrob.region?.name);
      // print("*"*100);

// ???????????? ?????????????? ???? ??????????????
      if(dataToMap2[csvTable[i][6]]!=null){

        dataToMap2[csvTable[i][6]]!.add(Price(
          year: csvTable[i][8],
          p: double.parse(csvTable[i][4].toString()),
        ));
      }

      if(csvTable[i][7].toString().toLowerCase().contains(AllDrob.region?.name?.toLowerCase()??"")&&csvTable[i][6].toString().toLowerCase().contains(AllDrob.city
          ?.name?.toLowerCase()??"")&&csvTable[i][5].toString().toLowerCase().contains(AllDrob.town?.name?.toLowerCase()??"")){

        String? a=AllDrob.region?.name;

        price2.add(Price(
          year: csvTable[i][8],
          p: double.parse(csvTable[i][4].toString()),
        ));
        // price.add(Price(year: 100+i.toDouble(), newPrice: i*10, oldPrice: i*5));

      }

    }

    price2=dataToMap2[AllDrob.city?.name]??[];
    Map<int,Price>a={ };
    price2.forEach((element) {
      a[element.year]=element;
    });
    price2=   a.entries.map((e) => e.value).toList();

    print("dataToMap  =>${dataToMap.length}");
    print("city?.name  =>${AllDrob.city?.name}");
    print("price.length  =>${price.length}");
    price2. forEach((element) {
      print("element.year   =>  ${element.year}");
      print("element.year   =>  ${element.year}");
    });
  }
}

class Price {
  int year;
  double p;

  Price({required this.year, required this.p});
}