import 'package:flutter/material.dart';
import 'package:predictas1/settings/setting.dart';

import 'package:predictas1/networking/Advert_json.dart';

class MyHome extends StatefulWidget {
  AdvertsJson? adverts;

  MyHome(this.adverts);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
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
                      offset: const Offset(0, 3), // changes position of shadow
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
                        child: widget.adverts?.eEmbedded?.adverts?[pos].photo !=
                                null
                            ? Image.network(
                                widget.adverts?.eEmbedded?.adverts?[pos].photo??"",
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
                                widget.adverts?.eEmbedded?.adverts?[pos].title??"",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.adverts?.eEmbedded?.adverts?[pos].price.toString()??""
                              // numberFormat.format(adverts.price) +
                              //     ' ' +
                              //     SettingsApp.moneySymbol,
                             , style: TextStyle(
                                  color: Colors.black,//framColor,
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
                                    "${ widget.adverts?.eEmbedded?.adverts?[pos].region?.name??""}, ${widget.adverts?.eEmbedded?.adverts?[pos].city?.name??""}",
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // print("annonce ajouté");
                                    // isFavorite != isFavorite;
                                  },
                                  child: Icon(
                                  //  widget.adverts?.eEmbedded?.adverts?[pos].region.
                                       // ?
                                  Icons.favorite_outline_rounded
                                       // : Icons.favorite,
                                   , color: Colors.pink,
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
    );
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
