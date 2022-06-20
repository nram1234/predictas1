import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:predictas1/myhome.dart';
import 'package:predictas1/n/all_dro_stat.dart';
import 'package:predictas1/user_fav_scr.dart';
import 'package:searchfield/searchfield.dart';
import 'Dashboard.dart';
import 'Login_Screen.dart';
import 'Profil.dart';
import 'Settings/httpadvert.dart';
import 'api/ref_json.dart';
import 'n/dio_singleton.dart';
import 'networking/Advert_json.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({ Key? key }) : super(key: key);

  @override
  _SearchScreen createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  String? _selectedItem;
  TextEditingController textEditingController=TextEditingController();


  List<RefJson>? cities = [];
  RefJson? city;
  List<RefJson> towns = [];
  RefJson? town;
  AdvertsJson? advertsJson;


  List<RefJson>? regions = [];
  RefJson? region;



  @override
  Widget build(BuildContext context) {
    const List <String>
    _list = <String>[];
    return Scaffold(

      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.teal,
          title: const Text('Predictas', style: TextStyle(
            color: Colors.white,
          ),),
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



      body:
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/prediction.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Text(
                      'Chercher votre futur bien', style: TextStyle(
                        fontSize: 25
                        ,
                        color: Colors.blueGrey
                    ),),
                  )),
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text('Entrer une adresse', style: TextStyle(
                            fontSize: 16,
                            color: Colors.blueGrey
                        ),),
                      ),
                      // Container(
                      //   width: double.infinity,
                      //   margin: EdgeInsets.symmetric(horizontal: 30),
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(10),
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.grey.withOpacity(0.2),
                      //         blurRadius: 10,
                      //         offset: Offset(0, 10),
                      //       ),
                      //     ],
                      //   ),
                      //
                      //   child: SearchField(controller: textEditingController,
                      //     suggestions: _list.map((e) =>
                      //         SearchFieldListItem(e)).toList(),
                      //     hint: 'Rechercher',
                      //     searchInputDecoration: InputDecoration(
                      //       prefixIcon: Icon(Icons.search,color: Colors.teal,),
                      //
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //           color: Colors.blueGrey.shade200,
                      //           width: 5,
                      //         ),
                      //
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //           width: 2,
                      //           color: Colors.blue.withOpacity(0.8),
                      //         ),
                      //         borderRadius: BorderRadius.circular(10),
                      //
                      //       ),
                      //     ),
                      //     maxSuggestionsInViewPort: 6,
                      //     itemHeight: 50,
                      //     suggestionsDecoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //
                      //     onSubmit: (value) {
                      //
                      //
                      //
                      //
                      //
                      //       setState(() {
                      //
                      //         ///ToDo  make call api
                      //
                      //
                      //
                      //         _selectedItem = value as String?;
                      //       });
                      //       print(value);
                      //     },
                      //   ),
                      // ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),

                        child:  DropdownButton<RefJson>(
                          underline: SizedBox(),
                          isExpanded: true,
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: Text("Departement"),
                          ),
                          value: city,
                          iconSize: 24,
                          elevation: 16,
                          onChanged: (v){
                            city=v;
                            AllDrob.city=v;
                            print(v?.name);
                            getTown(v?.id);
                            setState(() {

                            });
                          },
                          items:  cities
                              ?.asMap()
                              .entries
                              .map<DropdownMenuItem<RefJson>>((value) {
                            return DropdownMenuItem<RefJson>(
                              value: value.value,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8),
                                child: Text(value.value.name??""),
                              ),
                            );
                          }).toList(),
                        ),
                      ),


                      const SizedBox(
                        height: 8,
                      ),

                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),

                        child:  DropdownButton<RefJson>(
                          underline: SizedBox(),
                          isExpanded: true,
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: Text("Commune"),
                          ),
                          value: town,
                          iconSize: 24,
                          elevation: 16,
                          onChanged:   (v){
                            town=v;
                            AllDrob.town=v;
                            print(v?.name);
                            setState(() {

                            });
                          },
                          items: towns
                              .map<DropdownMenuItem<RefJson>>((RefJson value) {
                            return DropdownMenuItem<RefJson>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8),
                                child: Text(value.name??""),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),

                        child: DropdownButton<RefJson>(
                          underline: SizedBox(),
                          isExpanded: true,
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: Text("Region"),
                          ),
                          value: region,
                          iconSize: 24,
                          elevation: 16,
                          onChanged: (v){
                            region=v;


                            //   getTown(v?.id);
                            AllDrob.region=v;
                            print(v?.name);
                            setState(() {

                            });
                          },
                          items:  regions
                              ?.asMap()
                              .entries
                              .map<DropdownMenuItem<RefJson>>((value) {
                            return DropdownMenuItem<RefJson>(
                              value: value.value,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8),
                                child: Text(value.value.name??""),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),

                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _selectedItem == null ? Text(
                      ' Continuer', style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey
                    ),) : Text(_selectedItem!, style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.w600
                    )),
                    MaterialButton(
                      onPressed: () {
                        print("iam going to get data");
                        // Add List favorite into home
                        // Add List favorite into home
                        if(AllDrob.region!=null||AllDrob.city!=null||AllDrob.town!=null){
                          getList(filters: textEditingController?.text??"");
                        }else{



                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("champs vide"),
                          ));
                        }

                        // fetchList().then((value){
                        //   print(value?.toJson());                          });

                      },
                      color: Colors.black,
                      minWidth: 30,
                      height: 30,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),

                      padding: EdgeInsets.all(0),
                      child: Icon(Icons.arrow_forward_ios, color: Colors.blueGrey, size: 13,),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getRegions();
    getCity();
  }

  /*   searchCity(String query) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    final searchLower = query.toLowerCase();
  }

  @override
  setState( () {
  this.query = query;
  this.id = id;
  this.name = name;
  });*/


  final DioSingleton dioSingleton = DioSingleton();
  Future<dynamic> getList({  filters}) async {
    var data;

    await dioSingleton.dio//&town=${town?.id}&regions=${region?.id}&city=${city?.id}&search=$filters
        .get('https://lecoinoccasion.fr/api/v1/adverts?categoryGroup=6&city=${city?.id??""}&town=${town?.id??""}}'//, queryParameters: filters
    )
        .then((value) {
      advertsJson= AdvertsJson.fromJson(value.data);
      print(advertsJson?.toJson());
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>MyHome (advertsJson)),
      );
      // print("value.dabbbbbbbbbbbbbbbbbbbbbbbbbbta");
      // var logger = Logger();
      //
      // logger.d(value.data);
      //devlog.log(value.data.toString() );
      print(advertsJson?.eEmbedded?.adverts);
      data = value.data;
    });


    return advertsJson;
  }


















  updateCity(RefJson ci) {

  }

  updateTown(RefJson town) {
    // if (town.id == 0) {
    //   if (Get.find<TapHomeViewController>().search["town"] != null) {
    //     Filter.data.remove("town");
    //     Get.find<TapHomeViewController>().search.remove("town");
    //   }
    //   town = null;
    //   tapHomeViewController.filterUpdate();
    // } else {
    //   this.town = town;
    //   tapPublishViewController.validateTown.value="";
    //   Get.find<TapHomeViewController>().setSearch("town", town.id.toString());
    //   tapHomeViewController.searchAddLinke =
    //       tapHomeViewController.searchAddLinke + "&town=${town.id}";
    //   tapPublishViewController.town = town;
    //   tapHomeViewController.setSearch("town", town.id);
    //   tapPublishViewController.myAds["town"] = town.id;
    //   tapPublishViewController.myAdsView["town"] = town.name;
    //   update();
    // }
  }

  // Future updateTowns(id) async {
  //
  //   await _townsApi.getList().then((value) {
  //     towns = value.data;
  //
  //
  //
  //   });
  // }

  updateCityAndTown() {
    // city = null;
    // tapPublishViewController.citie = null;
    // tapPublishViewController.town = null;
    // town = null;
    //
    // update();
  }







  Future< List<RefJson>> getCity()async{

    List<RefJson> cities = [];
    await   dioSingleton.dio.get('https://lecoinoccasion.fr/api/v1/simple/cities').then((value) {


      cities =
      RefListJson.fromJson(value.data).data!;

    });
    this.cities=cities;
    setState(() {

    });
    return cities;

  }

  Future< List<RefJson>>  getTown(id)async{
    town=null;
    List<RefJson> towns = [];
    await  dioSingleton.dio.get('https://lecoinoccasion.fr/api/v1/simple/towns/$id').then((value) {
      print(value.data);
      towns   = RefListJson.fromJson(value.data).data!;
      this.towns=towns;
    });
    setState(() {

    });
    return towns;


  }

  Future< List<RefJson>>  getRegions( )async{

    List<RefJson> regions = [];
    await  dioSingleton.dio.get('https://lecoinoccasion.fr/api/v1/simple/regions').then((value) {
      print(value.data);
      regions   = RefListJson.fromJson(value.data).data!;
      this.regions=regions;
    });
    setState(() {

    });
    return regions;


  }
}


//"https://lecoinoccasion.fr/api/v1/simple/regions"



