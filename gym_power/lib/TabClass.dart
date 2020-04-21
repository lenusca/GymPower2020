import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_power/home.dart';
import 'package:gym_power/loading.dart';
import 'package:gym_power/models/user.dart';
import 'package:gym_power/playlist.dart';
import 'package:gym_power/scheduleClass.dart';
import 'package:gym_power/service/database.dart';
import 'package:gym_power/sidebar.dart';
import 'package:provider/provider.dart';
import 'package:gym_power/classDetails.dart';

class TabClass extends StatefulWidget {
  static String tag = 'TabClass';
  @override
  TabClassState createState() => new TabClassState();
}

class TabClassState extends State<TabClass> {


  @override
  final List<Card> buttonClass = [];
  final List<SimpleDialogOption> schedule = [];


  // Número total de inscritos
  int inscritos(data){
    int inscritosTotal = 0;
    for(int i = 0; i < data.length; i++){
      inscritosTotal += data[i];
    }
    return inscritosTotal;
  }

  //popup schedule
  createAlertSchedule(BuildContext context, document) {
    //createOptions(document);
    return showDialog(context: context, builder: (context) {

      return SimpleDialog(
        title: Text('Choose the Class ', textAlign: TextAlign.center,),
        children : schedule
      );
    });
  }

   bottomClass (documents, String nome, String img, int numSocio, String userID) async{
    buttonClass.clear();

    // lotação total
    for(int i = 0; i < documents.length; i++){
      buttonClass.add(Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: Container(
          height: 130,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
              image: NetworkImage(documents[i].data['img']),
              fit: BoxFit.fill,
            ),

          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 200,
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child:  Text(documents[i].data['nome'], style: TextStyle(color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.w500), textAlign: TextAlign.left, ),
                  ),

                  Container(
                    margin: EdgeInsets.fromLTRB(70, 0, 0, 0),
                    alignment: Alignment.centerRight,
                    color: Colors.white,
                    child: Text(inscritos(documents[i].data['inscritos']).toString()+"/"+inscritos(documents[i].data['lotacao']).toString(), style: TextStyle(color: Colors.deepOrangeAccent[200]),),
                  ),
                ],




              ),
              Row(
                children: <Widget>[

                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: inscritos(documents[i].data['inscritos'])<inscritos(documents[i].data['lotacao'])?RaisedButton(
                      clipBehavior: Clip.hardEdge,
                      onPressed: () {
                        schedule.clear();
                        var aulasInscritas = [];
                        var inscreverAula = {};
                        print("AQUI"+userID);
                        Firestore.instance.collection('users').document(userID).get().then((doc){
                          aulasInscritas = doc.data['aulasFrequentadas'];
                        });

                        print(aulasInscritas);
                        for(int j=0; j<documents[i].data['diaSemana'].length; j++){
                            schedule.add(
                              SimpleDialogOption(
                                child: Card(
                                    shape: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.5,
                                            color: Colors.grey
                                        )
                                    ),
                                    elevation: 0.0,
                                    child: ListTile(
                                        title: Text(documents[i].data['diaSemana'][j]+" "+documents[i].data['inicioHora'][j]+ " "+ documents[i].data['inscritos'][j].toString()+"/"+documents[i].data['lotacao'][j].toString(), style: TextStyle(color: Colors.deepOrange,fontSize:20),)
                                    )),
                                //sair do popup
                                onPressed: () {

                                  var inscritosArray = [];

                                  // update o número de inscritos
                                  inscritosArray = documents[i].data['inscritos'];
                                  inscritosArray[j] += 1;
                                  Firestore.instance.collection('ginasioAulas')
                                      .document(documents[i].documentID).updateData({
                                    'inscritos': inscritosArray
                                  })
                                      .catchError((e) {
                                    print(e);
                                  });
                                  // update o workactivities
                                  inscreverAula = {'horaInicio': documents[i].data['inicioHora'][j], 'horaFim': documents[i].data['fimHora'][j], 'nome': documents[i].data['nome']};

                                  if(aulasInscritas == []){
                                    aulasInscritas = [inscreverAula];
                                  }
                                  else {
                                    aulasInscritas.add(inscreverAula);
                                  }

                                  Firestore.instance.collection('users')
                                      .document(userID).updateData({
                                    'aulasFrequentadas': aulasInscritas
                                  })
                                      .catchError((e) {
                                    print(e);
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            );

                        }
                        createAlertSchedule(context, documents[i]);
                      },

                      color: Colors.deepOrangeAccent[200],
                      splashColor: Colors.deepOrangeAccent[200],
                      child: Text("RESERVE", style: TextStyle(color: Colors.white),),
                    ):
                    Container(
                      width: 105,
                      child: Row(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.times, color: Colors.red,),
                          Text("FULL", style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),

                  ),

                  Container(
                      width: 60,
                      margin: EdgeInsets.fromLTRB(155, 0, 0, 0),
                      alignment: Alignment.bottomRight,
                      child: FlatButton.icon(
                        label: Text(""),
                        icon: Icon(FontAwesomeIcons.infoCircle, size: 20, color: Colors.white,),
                        splashColor: Colors.transparent,
                        onPressed: (){
                          var route = new MaterialPageRoute(builder: (BuildContext context) => new GymClass( uid: documents[i].documentID,  nome: nome, img: img, numSocio: numSocio, userID: userID, ));
                          Navigator.of(context).push(route);
                        },
                      )
                  ),
                ],
              ),

            ],
          ),
        ),
      ));
    }
  }

  AllClasses(String nome, String img, int numSocio, String userID){
    return StreamBuilder(
      stream: Firestore.instance.collection('ginasioAulas').snapshots(),
      builder: (context, snapshot){

        if(!snapshot.hasData){
          return Loading();
        }
        else{
          bottomClass(snapshot.data.documents, nome, img, numSocio, userID);
          return ListView.builder(
            itemCount: buttonClass.length,
            itemBuilder: (BuildContext context, int index){
              return buttonClass[index];
            },
          );
        }
      },
    );
  }

  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot){
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return  DefaultTabController(
            length: 3,
            child: Scaffold(
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
                bottom: TabBar(

                  isScrollable: true,
                  indicatorWeight: 2.0,
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(child: Container(
                      child: Text("CLASSES", style: TextStyle(color: Colors.white, fontSize: 16),),),
                    ),
                    Tab(child: Container(
                      child: Text("SCHEDULE", style: TextStyle(color: Colors.white, fontSize: 16),),),
                    ),
                    Tab(child: Container(
                      child: Text("PLAYLIST", style: TextStyle(color: Colors.white, fontSize: 16),),),
                    ),
                  ],
                ),
              ),
              drawer: SideBar(nome: userData.nome, numSocio: userData.numSocio, img: userData.img,),
              body: TabBarView(
                children: [
                  AllClasses(userData.nome, userData.img, userData.numSocio, userData.uid), // Nome da função que queres que apareça
                  ScheduleClasses(numSocio: userData.numSocio, img: userData.img, nome: userData.nome,),
                  Playlist(),
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




