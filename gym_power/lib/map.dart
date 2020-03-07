import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gym_power/home.dart';
import 'package:path/path.dart' as Path;
import 'package:gym_power/loading.dart';
import 'package:gym_power/models/user.dart';
import 'package:gym_power/service/database.dart';
import 'package:gym_power/sidebar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';




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
    print(gyms['Name']);
    print(gyms['Localization'].latitude);

    allmarkers.add(Marker(markerId: MarkerId(gyms['Name']),
        position: LatLng(
            gyms['Localization'].latitude, gyms['Localization'].longitude),
        draggable: false));
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
                        width: double.infinity,
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
