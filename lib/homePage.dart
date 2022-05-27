import 'package:flutter/material.dart';

class PropertyItem extends StatelessWidget {
  PropertyItem({ Key? key, required this.data }) : super(key: key);
  final data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 240,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: .5,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        children: [
          /*Image(
            data["image"],
            radius: 25, width: double.infinity, height: 150, image: null,
          ),*/
          Positioned(
              right: 20, top: 130,
              child: Icon(
                Icons.favorite_border,
                color: Colors.pink,
              )),
          Positioned(
              left: 15, top: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data["name"], maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Icon(
                        Icons.place_outlined, color: Colors.black, size: 13,),
                      SizedBox(width: 3,),
                      Text(data["location"],
                        style: TextStyle(fontSize: 13, color: Colors.black),),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Text(data["price"], style: TextStyle(fontSize: 15,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500),),
                ],
              )
          ),
        ],
      ),
    );
  }
}