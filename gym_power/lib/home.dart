import 'package:flutter/material.dart';
import 'package:gym_power/loading.dart';
import 'package:gym_power/models/user.dart';
import 'package:gym_power/service/auth.dart';
import 'package:gym_power/service/database.dart';
import 'package:gym_power/sidebar.dart';
import 'package:gym_power/signin.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static String tag = "home";
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    // para ir buscar o uid do utilizador que fez login
    final user = Provider.of<User>(context);

    return loading ? Loading() : StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot){
          if(snapshot.hasData){
            UserData userData = snapshot.data;
            return  Container(
              child: Scaffold(
                drawer: SideBar(nome: userData.nome, numSocio: userData.numSocio,),
                backgroundColor: Colors.brown[50],
                appBar: AppBar(
                  title: Text(userData.nome),
                  backgroundColor: Colors.brown[400],
                  elevation: 0.0,
                  actions: <Widget>[
                    FlatButton.icon(
                      icon: Icon(Icons.person),
                      label: Text('logout'),
                      onPressed: () async {
                        await _auth.signOut();
                        setState(() {
                          loading = true;
                        });
                        Navigator.of(context).pushReplacementNamed(SignIn.tag);
                      },
                    ),
                  ],
                ),

              ),
            );
          }

          else{
            return Loading();
          }




        }
    );


  }
}