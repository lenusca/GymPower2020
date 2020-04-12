import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_power/TabClass.dart';
import 'package:gym_power/home.dart';
import 'package:gym_power/loading.dart';
import 'package:gym_power/sidebar.dart';

class GymClass extends StatefulWidget {
  final String uid;
  final String nome;
  final String img;
  final int numSocio;

  GymClass({this.uid, this.nome, this.img, this.numSocio});

  @override
  _GymClassState createState() => _GymClassState();
}

class _GymClassState extends State<GymClass> {

  @override

  Widget build(BuildContext context) {
    // TODO: implement build
    List<MenuItem> data = [];

    int lotacao(data){
      int lotacaoTotal = 0;
      for(int i = 0; i < data.length; i++){
        lotacaoTotal += data[i];
      }
      return lotacaoTotal;
    }

    int inscritos(data){
      int inscritosTotal = 0;
      for(int i = 0; i < data.length; i++){
        inscritosTotal += data[i];
      }
      return inscritosTotal;
    }

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
        drawer: SideBar(nome: widget.nome, numSocio: widget.numSocio, img: widget.img,),
        body: StreamBuilder(
            stream: Firestore.instance.collection('ginasioAulas').document(widget.uid).snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return Loading();
              }
              else{
                data.clear();
                var inscritosArray = [];
                for (int i = 0; i < snapshot.data['inicioHora'].length; i++) {
                  inscritosArray = snapshot.data['inscritos'];
                    data.add(MenuItem(
                        elevation: 50.0,
                        backgroundColor: Colors.black54,
                        child: new Icon(FontAwesomeIcons.firstOrder, color: Colors.white54,),
                        title: snapshot.data['diaSemana'][i],
                        titleColor: Colors.deepOrangeAccent,
                        subtitle: "Start: " + snapshot.data['inicioHora'][i] + "                 "+snapshot.data['inscritos'][i].toString()+"/"+snapshot.data['lotacao'][i].toString()+"\n"+ "End: " + snapshot.data['fimHora'][i],
                        subTitleColor: Colors.white54,

                        onTap: () {
                          inscritosArray[i] += 1;
                          Firestore.instance.collection('ginasioAulas')
                              .document(widget.uid).updateData({
                            'inscritos': inscritosArray
                          })
                              .catchError((e) {
                            print(e);
                          });
                        }
                    ));

                }
                return Container(
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: ClipPath(
                          clipper: ClippingClass(),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 250.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(snapshot.data['img']),
                                )
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 190,
                        left: 18.0,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: (){
                              Navigator.of(context).pushReplacementNamed(TabClass.tag);
                            },
                            icon: Icon(
                              FontAwesomeIcons.backward,
                            size: 40.0,
                            color: Colors.deepOrange[200],),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 290, 20, 0),

                        child: Text(
                         snapshot.data['descricao'],
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                      ),

                      Container(
                        width: 50,
                        height: 30,
                        margin: EdgeInsets.fromLTRB(10, 250, 20, 0),
                        alignment: Alignment.centerRight,

                        child: Text(inscritos(snapshot.data['inscritos']).toString()+"/"+lotacao(snapshot.data['lotacao']).toString(), style: TextStyle(color: Colors.deepOrangeAccent[200]),),
                      ),

                      Container(
                        margin: EdgeInsets.fromLTRB(110, 465, 20, 0),
                        child: Text("RESERVE", style: TextStyle(fontWeight: FontWeight.bold),),
                      ),

                    ],
                  ),
                );
              }
            }
            ),
      floatingActionButton: BoomMenu(
        subtitle: "RESERVE",
        marginRight: 110,
        marginBottom: 45,
        backgroundColor: Colors.deepOrangeAccent,
        child: new Icon(Icons.add_circle),
        titleColor: Colors.black,
        title: "RESERVE",
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        onOpen: (){},
        onClose: (){},
        overlayColor: Colors.black,
        overlayOpacity: 0.7,
        children: data,
      ),
    ); 
      
  }


}


class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {

    var path = Path();
    path.lineTo(0.0, size.height-50);
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

