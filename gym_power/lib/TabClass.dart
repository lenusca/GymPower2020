import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_power/class.dart';
import 'package:gym_power/home.dart';
import 'package:gym_power/loading.dart';
import 'package:gym_power/models/classes.dart';
import 'package:gym_power/models/user.dart';
import 'package:gym_power/service/database.dart';
import 'package:gym_power/sidebar.dart';
import 'package:provider/provider.dart';

class TabClass extends StatefulWidget {
  static String tag = 'TabClass';
  @override
  TabClassState createState() => new TabClassState();
}

class TabClassState extends State<TabClass> {
  final List<Card> buttonClass = [];
  bottomClass(documents, String nome, String img, int numSocio){
    buttonClass.clear();
    print(documents.length);
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
                      child: Text(documents[i].data['inscritos'].toString()+"/"+documents[i].data['limite'].toString(), style: TextStyle(color: Colors.deepOrangeAccent[200]),),
                    ),
                    ],




              ),
              Row(
                children: <Widget>[

                  Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: documents[i].data['inscritos']<documents[i].data['limite']?RaisedButton(
                      clipBehavior: Clip.hardEdge,
                      onPressed: () => Firestore.instance.collection('ginasioAulas').document(documents[i].documentID).updateData({'inscritos': documents[i]['inscritos']+1}).catchError((e) {
                       print(e);
                      }) ,
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
                          print(documents[i].documentID);
                          print(documents[i].data['idaula']);
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

  AllClasses(String nome, String img, int numSocio){
    return StreamBuilder(
      stream: Firestore.instance.collection('ginasioAulas').snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Loading();
        }
        else{
          bottomClass(snapshot.data.documents, nome, img, numSocio);
          print("AQUI"+buttonClass.length.toString());
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

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot){
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return  DefaultTabController(
            length: 1, //
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
                  indicatorWeight: 6.0,
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(child: Text("Classes", style: TextStyle(color: Colors.white, fontSize: 15),),),
                    //Tab(child: Text("GRAPH", style: TextStyle(color: Colors.white, fontSize: 24),),),
                  ],
                ),
              ),
              drawer: SideBar(nome: userData.nome, numSocio: userData.numSocio, img: userData.img,),
              body: TabBarView(
                children: [
                  AllClasses(userData.nome, userData.img, userData.numSocio,), // Nome da função que queres que apareça
                  //WorkActivities(), // Nome da função que queres que apareça
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

