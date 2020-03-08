import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gym_power/home.dart';
import 'package:gym_power/loading.dart';
import 'package:gym_power/models/user.dart';
import 'package:gym_power/service/database.dart';
import 'package:gym_power/sidebar.dart';
import 'package:provider/provider.dart';

class gpsMap extends StatefulWidget{
  static String tag = "map";
  @override
  gpsMapState createState() => gpsMapState();
}

class gpsMapState extends State<gpsMap> {
  bool mapToggle = false;
  var currentLocation;
  var gyms = [];
  GoogleMapController mapController;
  PageController _pageController;
  List<Marker> allmarkers = [];

  @override
  void initState() {
    super.initState();
    // Vai buscar a localiozação atual do telemovel
    Geolocator().getCurrentPosition().then((onValue) {
      setState(() {
        currentLocation = onValue;
        mapToggle = true;
        localizationGyms();
      });
    });
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8);
  }

  // ir buscar a base dados todas as localizações
  localizationGyms() {
    gyms = [];
    Firestore.instance.collection('gymsLocalization').getDocuments().then((
        docs) {
      if (docs.documents.isNotEmpty) {
        for (int i = 0; i < docs.documents.length; i++) {
          gyms.add(docs.documents[i].data);
          initMarker(docs.documents[i].data);
        }
      }
    });
  }

  initMarker(gyms) {
    allmarkers.add(Marker(markerId: MarkerId(gyms['Name']),
        position: LatLng(
            gyms['Localization'].latitude, gyms['Localization'].longitude),
        infoWindow: InfoWindow(title: gyms['Name'], snippet: 'CLOSED: '+gyms['Fechado']),
        draggable: false));
  }

  moveCamera(){
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(gyms[_pageController.page.toInt()]['Localization'].latitude, gyms[_pageController.page.toInt()]['Localization'].longitude),
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0
    )));
  }
  _gymsList(index){
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget){
        double value = 1;
        if(_pageController.position.haveDimensions){
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3)+0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value)*130.0,
            width: Curves.easeInOut.transform(value)*900.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
        onTap: (){
          moveCamera();
        },
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                height: 125.0,
                width: 275.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 10.0
                    )
                  ]
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 90.0,
                        width: 90.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0)
                          ),
                          image: DecorationImage(image: NetworkImage(
                              gyms[index]['Image']
                          ), fit: BoxFit.cover,  )
                        ),
                      ),
                      SizedBox(width: 5.0,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(gyms[index]['Name'], style: TextStyle(color: Colors.deepOrangeAccent[200], fontSize: 12.0, fontWeight: FontWeight.bold),),
                          Text('CLOSED ' +gyms[index]['Fechado'], style: TextStyle(color: Colors.red, fontSize: 9.0, fontWeight: FontWeight.w400),),
                          Container(
                            width: 160.0,
                            child:  Text(gyms[index]['Descricao'], style: TextStyle(color: Colors.grey, fontSize: 10.0, fontWeight: FontWeight.w300),),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    void onMapCreated(GoogleMapController controller) {
      setState(() {
        mapController = controller;
      });
    }
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          return Container(
            child: Scaffold(
              drawer: SideBar(nome: userData.nome,
                numSocio: userData.numSocio,
                img: userData.img,),
              appBar: AppBar(
                title: Text("Localization",
                    style: TextStyle(color: Colors.white, fontSize: 25)),
                backgroundColor: Colors.deepOrangeAccent[200],
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.home),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pushNamed(Home.tag);
                      }
                  )
                ],
              ),
              body: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        // -80.0 por causa da app bar
                        height: MediaQuery
                            .of(context)
                            .size
                            .height - 80.0,
                        width: MediaQuery.of(context).size.width,
                        child: mapToggle ? GoogleMap(
                          onMapCreated: onMapCreated,
                          // posição inicial a do telemovel
                          markers: Set.from(allmarkers),
                          initialCameraPosition: CameraPosition(
                              target: LatLng(currentLocation.latitude,
                                  currentLocation.longitude), zoom: 10.0),
                        ) : Center(child: Text("Loading...", style: TextStyle(
                            color: Colors.deepOrangeAccent[200],
                            fontSize: 20.0),),),
                      ),
                      Positioned(
                        bottom: 20.0,
                        child: Container(
                          height: 200.0,
                          width: MediaQuery.of(context).size.width,
                          child: PageView.builder(
                              controller: _pageController,
                              itemCount: gyms.length,
                              itemBuilder: (BuildContext context, int index){
                                return _gymsList(index);
                              },
                          ),
                        ),
                      ),

                    ],
                  )
                ],
              ),
            ),

          );
        }
        else {
          return Loading();
        }
      },
    );
  }

}
