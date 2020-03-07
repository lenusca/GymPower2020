import 'package:flutter/material.dart';
import 'package:gym_power/healthTable.dart';
import 'package:gym_power/home.dart';
import 'package:gym_power/loading.dart';
import 'package:gym_power/models/user.dart';
import 'package:gym_power/service/database.dart';
import 'package:gym_power/sidebar.dart';
import 'package:provider/provider.dart';

class TabHealth extends StatefulWidget {
  static String tag = 'TabHealth';
  @override
  TabHealthState createState() => new TabHealthState();
}

class TabHealthState extends State<TabHealth> {

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
                title: Text("Health", style: TextStyle(color: Colors.white, fontSize: 25)),
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
                      Tab(child: Text("TABLE", style: TextStyle(color: Colors.white, fontSize: 15),),),
                      //Tab(child: Text("GRAPH", style: TextStyle(color: Colors.white, fontSize: 24),),),
                      //Tab(child: Text("GRAPH", style: TextStyle(color: Colors.white, fontSize: 24),),),
                    ],
                ),
              ),
              drawer: SideBar(nome: userData.nome, numSocio: userData.numSocio, img: userData.img,),
              body: TabBarView(
                children: [
                  HealthTable(), // Nome da função que queres que apareça
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