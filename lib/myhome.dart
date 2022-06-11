import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:predictas1/settings/setting.dart';
import 'package:intl/intl.dart';
import 'package:predictas1/networking/Advert_json.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'Login_Screen.dart';
import 'Register_Screen.dart';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: SfCartesianChart(
                series: <ChartSeries>[
                  LineSeries<Price, double>(
                      dataSource: price,
                      xValueMapper: (Price p, _) => p.year,
                      yValueMapper: (Price p, _) => p.newPrice,
                      color: Colors.greenAccent,
                      enableTooltip: true,
                      markerSettings: MarkerSettings(
                          isVisible: true,
                          height: 1,
                          width: 1,
                          shape: DataMarkerType.circle,
                          borderWidth: 3,
                          borderColor: Colors.black),
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                      )),
                  // LineSeries<Price,double>(dataSource: price, xValueMapper: (Price p,_)=>p.year,
                  //     yValueMapper: (Price p,_)=>p.oldPrice,color: Colors.blueAccent
                  //
                  // )
                ]
                //,primaryXAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift)
                ,
                primaryYAxis: NumericAxis(
                    numberFormat:
                        NumberFormat.simpleCurrency(decimalDigits: 0)),
                isTransposed: true,
                crosshairBehavior: CrosshairBehavior(enable: true),zoomPanBehavior:  ZoomPanBehavior(
                // Enables pinch zooming
                  enablePinching: true, enableDoubleTapZooming: true,enablePanning: true,zoomMode: ZoomMode.xy,enableSelectionZooming: true
              ),
              )),
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
                                          // print("annonce ajouté");
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
                                                    .collection('fav')
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
                                                    .collection('fav')
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
                                              }

                                              //   getD();

                                              // .collection("cities")
                                              // .doc("LA")
                                              // .set(city)
                                              // .onError((e, _) => print("Error writing document: $e"));

                                            }
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
    final csvData = await rootBundle.loadString("assets/pricePredicted.csv");
    csvTable = const CsvToListConverter().convert(csvData);
// print(csvTable);
//     print(csvData);
    print(csvTable.length);
    print(csvTable.first); //csvTable.length
    for (int i = 1; i < csvTable.length; i++) {
      print(csvTable[i][4]);
      print(csvTable[i][3]);
      print(csvTable[i][5]);
      price.add(Price(
          year: double.parse(csvTable[i][4].toString()),
          newPrice: double.parse(csvTable[i][3].toString()),
          oldPrice: double.parse(csvTable[i][5].toString())));
      // price.add(Price(year: 100+i.toDouble(), newPrice: i*10, oldPrice: i*5));
    }
  }
}

//
//
//
//
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Container(
// padding: const EdgeInsets.all(1),
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: const BorderRadius.only(
// topLeft: Radius.circular(10),
// topRight: Radius.circular(10),
// bottomLeft: Radius.circular(10),
// bottomRight: Radius.circular(10)),
// boxShadow: [
// BoxShadow(
// color: Colors.grey.withOpacity(0.5),
// spreadRadius: 5,
// blurRadius: 7,
// offset: const Offset(0, 3), // changes position of shadow
// ),
// ],
// ),
// height: size.height * .26,
// child: Row(
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Expanded(
// flex: 1,
// child: Container(
// height: size.height * .2,
// child:adverts.eEmbedded.adverts.!=null? Image.network(
//
// adverts.photo,
// fit: BoxFit.fill,
// ):   Image.asset("assets/images/no-image.jpeg"),
// ),
// ),
// Expanded(
// flex: 1,
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// Container(
// child: Text(
// adverts.title,
// maxLines: 3,
// overflow: TextOverflow.ellipsis,
// style: TextStyle(
// fontWeight: FontWeight.bold, fontSize: 13),
// ),
// ),
// SizedBox(
// height: 10,
// ),
// Text(
// numberFormat.format(adverts.price) +
// ' ' +
// SettingsApp.moneySymbol,
// style: TextStyle(
// color: framColor,
// fontWeight: FontWeight.bold,
// fontSize: 15),
// softWrap: true,
// overflow: TextOverflow.fade,
// ),
// Spacer(),
// Row(
// children: [
// Icon(
// Icons.location_on,
// color: Colors.grey,
// size: 18,
// ),
// Container(
// width: size.width * .28,
// child: Text(
// "${adverts.region.name}, ${adverts.city.name}",
// softWrap: true,
// style: TextStyle(color: Colors.grey, fontSize: 12),
// overflow: TextOverflow.ellipsis,
// maxLines: 4,
// ),
// ),
// ],
// ),
// SizedBox(
// height: 4,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// InkWell(
// onTap: () {
// print("annonce ajouté");
// isFavorite != isFavorite;
// },
// child: Icon(
// isFavorite
// ? Icons.favorite_outline_rounded
//     : Icons.favorite,
// color: Colors.pink,
// ),
// )
// ],
// ),
// ],
// ),
// ),
// )
// ],
// ),
// ),
//);

class Price {
  double year;
  double newPrice;
  double oldPrice;

  Price({required this.year, required this.newPrice, required this.oldPrice});
}
