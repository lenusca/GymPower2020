import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gym_power/models/user.dart';
import 'package:provider/provider.dart';
import 'package:gym_power/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym_power/workout/countDownTimer.dart';
import 'package:gym_power/camera.dart';

class WorkoutMedium extends StatefulWidget {
  final userID;

  WorkoutMedium({Key key, this.userID}) : super(key: key);

  @override
  _WorkoutMediumState createState() => _WorkoutMediumState();
}

class _WorkoutMediumState extends State<WorkoutMedium> {

  /*updateData(selectedDoc, newValues) {
    Firestore.instance
        .collection('Exercicio')
        .document(selectedDoc)
        .updateData(newValues);
  }*/

  /*void reset() async{
    await Firestore.instance
        .collection('Exercicio').snapshots()
        .forEach((snapshot) async {
      List<DocumentSnapshot> documents = snapshot.documents;
      for (var document in documents) {
        await document.data.update(
          'check',
          (val) {
            val = "n";
            return val;
          },
        );
        print(document.data['check']);
      }
    });
       
  }*/

  @override
  List<Container> workout = [];
  getData(doc) {
   for(int i = 0; i<doc.length; i++){
       workout.add(Container(
        height: 200,
        //margin: EdgeInsets.all(0),
        decoration:  BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(width: 2.0, color: Colors.deepOrange[200]),
          ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              widthFactor: 1,
              alignment: Alignment.center,
              child: SizedBox(width: 120, height: 170, child: Image.network(doc[i].data['image']),),
            ),
            Container(
              width: 210,
              height: 170,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10, right: 10,),
              decoration: BoxDecoration(
              color: Colors.deepOrange[200],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8.0),
              ),
              child: new Container(
              margin: const EdgeInsets.only(top: 16.0, left: 10, right: 10),
              child: new Column(
                children: <Widget>[
                  Text(doc[i].data['nome'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      doc[i].data['nSerie']==null?Container():Text("Series: "+doc[i].data['nSerie'].toString(), style: TextStyle(fontSize: 16,),),
                      Text(" "),
                      doc[i].data['repeticao']==null?Container():Text("Repetition: "+doc[i].data['repeticao'].toString(), style: TextStyle(fontSize: 16,),),
                  ],),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      doc[i].data['peso']==null?Container():Text("Weight: "+ doc[i].data['peso'].toString()+ " Kg", style: TextStyle(fontSize: 16,),),
                      Text(" "),
                      doc[i].data['inclinacao']==null?Container():Text("Inclination: "+doc[i].data['inclinacao'].toString(), style: TextStyle(fontSize: 16,),),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      doc[i].data['tempo']==null ? Container() :Text("Time: "+doc[i].data['tempo'].toString()+"s", style: TextStyle(fontSize: 16,),),
                      Text(" "),
                      doc[i].data['velocidade']==null ? Container() :Text("Velocity: "+doc[i].data['velocidade'].toString(), style: TextStyle(fontSize: 16,),),
                    ],),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      doc[i].data['tempo']==null?Container():IconButton(
                      padding: EdgeInsets.only(right:30),
                      icon: FaIcon(FontAwesomeIcons.stopwatch, 
                        color: Colors.grey[200], 
                        size: 30,),
                      onPressed: (){
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context)=>CountDownTimer(time:doc[i].data['tempo'].toString())));
                      },),
                      doc[i].data['qrCode']==null?Container():IconButton(
                      padding: EdgeInsets.only(left:50),
                      icon: FaIcon(FontAwesomeIcons.camera, 
                        color: Colors.grey[200], 
                        size: 30,),
                      onPressed: (){
                        Navigator.of(context).push( 
                        MaterialPageRoute(builder: (context) => Camera()));
                      },
                        ),
                    ],),
                ],
                ),
              ),
          ),
          
		    ],)
       ));
   }
    
  }

  Widget build(BuildContext context) {
    workout = [];
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('Exercicio')
                .where('nivel', isEqualTo: 'medium').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

              if(!snapshot.hasData){

                return Loading();
              }
              else{
                //print(workout.length);
                //print(snapshot.data.documents.length);
                //print(snapshot.data.documents[0].data['nome']);
                getData(snapshot.data.documents);
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index){
                    return workout[index];
                  },

                );
              }
            })
    );

  }


}
