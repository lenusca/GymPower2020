import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_power/home.dart';
import 'package:gym_power/loading.dart';
import 'package:gym_power/sidebar.dart';


class GymClass extends StatelessWidget {
  static String tag = "class";
  final int uid;
  final String nome;
  final String img;
  final int numSocio;


  GymClass({this.uid, this.nome, this.img, this.numSocio});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Class Map", style: TextStyle(color: Colors.white, fontSize: 25)),
          backgroundColor: Colors.deepOrangeAccent[200],
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.home),
                color: Colors.white,
                onPressed:(){
                  Navigator.of(context).pushNamed(Home.tag);
                }
            )
          ],
        ),
        drawer: SideBar(nome: nome, numSocio: numSocio, img: img,),
        body: StreamBuilder(
            stream: Firestore.instance.collection('ginasioAulas').where('idaula', isEqualTo: uid).snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return Loading();
              }
              else{
                return Container(
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: ClipPath(
                          clipper: ClippingClass(),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 320.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(snapshot.data.documents[0]['img']),
                                )
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 270,
                        left: 18.0,

                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(FontAwesomeIcons.play,
                            color: Colors.red,
                            size: 40.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            })
    ); 
      
  }
}

class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height-40);
    path.quadraticBezierTo(size.width / 4, size.height,
        size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
