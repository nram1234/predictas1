import 'package:flutter/material.dart';
import 'package:predictas1/myhome.dart';
import 'package:searchfield/searchfield.dart';
import 'Dashboard.dart';
import 'Login_Screen.dart';
import 'Settings/httpadvert.dart';
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



  AdvertsJson? advertsJson;

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
            IconButton(icon: Icon(Icons.account_box, color: Colors.white),
                onPressed: () async {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }
            )
          ]
      ),

      body:
      Container(
        decoration: BoxDecoration(
        image: DecorationImage(
       image: AssetImage("assets/images/maison.png"),
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
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Commencer à chercher votre futur bien', style: TextStyle(
                        fontSize: 16,
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

                        child: SearchField(controller: textEditingController,
                          suggestions: _list.map((e) =>
                              SearchFieldListItem(e)).toList(),
                          hint: 'Rechercher',
                          searchInputDecoration: InputDecoration(
                            prefixIcon: Icon(Icons.search,color: Colors.teal,),

                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueGrey.shade200,
                                width: 5,
                              ),

                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Colors.blue.withOpacity(0.8),
                              ),
                              borderRadius: BorderRadius.circular(10),

                            ),
                          ),
                          maxSuggestionsInViewPort: 6,
                          itemHeight: 50,
                          suggestionsDecoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),

                          onSubmit: (value) {

                            setState(() {

                              ///ToDo  make call api



                              _selectedItem = value as String?;
                            });
                            print(value);
                          },
                        ),
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
                      'Entrer une adresse pour continuer', style: TextStyle(
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
                        getList();
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



  Future<dynamic> getList({Map<String, dynamic>? filters}) async {
var data;
    final DioSingleton dioSingleton = DioSingleton();
    await dioSingleton.dio
        .get('https://lecoinoccasion.fr/api/v1/adverts?categoryGroup=6'//, queryParameters: filters
    )
        .then((value) {
      advertsJson= AdvertsJson.fromJson(value.data);
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
}




