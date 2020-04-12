import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gym_power/home.dart';
import 'package:path/path.dart' as Path;
import 'package:gym_power/loading.dart';
import 'package:gym_power/models/user.dart';
import 'package:gym_power/service/database.dart';
import 'package:gym_power/sidebar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';



class Settings extends StatefulWidget{
  static String tag = "settings";

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  //saber o que foi inserido
  final _formKey = GlobalKey<FormState>();
  File _img;
  String filename;
  String _currentName, _currentPassword, _currentSexo, _currentImg;
  int _currentTelemovel;
  DateTime _currentDtNasci;
  final List<String> sexoList = ['F', 'M', 'Undetermined'];
  @override
  Widget build(BuildContext context) {

    Future uploadImage() async{
      StorageReference ref = FirebaseStorage.instance.ref().child(filename);
      StorageUploadTask upload = ref.putFile(_img);
      StorageTaskSnapshot taskSnapshot = await upload.onComplete;
      setState(() {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Profile Picture Uploaded")));
      });
    };

    Future getImage() async{
      var image = await ImagePicker.pickImage(source: ImageSource.gallery).then((image){
        setState(() {
          _img = image;
          filename=Path.basename(_img.path);
        });
      });
      uploadImage();
    };

    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot){
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return Container(
            child: Scaffold(
              drawer: SideBar(nome: userData.nome, numSocio: userData.numSocio, img: userData.img,),
              appBar: AppBar(
                title: Text("Account Settings", style: TextStyle(color: Colors.white, fontSize: 25)),
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
              body: Center(
                child: ListView(
                  padding: EdgeInsets.only(left: 24.0, right: 24.0),
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 30.0,),
                          // update imag
                          Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: ClipOval(
                                child: SizedBox(
                                  width: 180.0,
                                  height: 180.0,
                                  child: (_img != null) ? Image.file(_img, fit: BoxFit.fill,) : Image.network(userData.img, fit: BoxFit.fill,),
                                ),
                              ),

                              radius: 80.0,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.camera_alt),
                            color: Colors.grey,
                            iconSize: 30.0,
                            onPressed: (){
                              getImage();
                            },
                          ),

                          SizedBox(height:10.0),
                          // update do nome
                          TextFormField(
                            decoration: new InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(vertical:0.0, horizontal: 0.0),
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              border: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                  borderSide: new BorderSide(color: Colors.deepOrangeAccent[200])
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(15.0),
                                child:Icon(Icons.perm_identity, color: Colors.deepOrange[200]),
                              ),
                              //icon: Icon(Icons.person),
                              filled: false,
                              hintText: 'First and Last Name',
                              labelText: 'Name',
                              labelStyle: TextStyle(inherit: true),
                            ),
                            cursorColor: Colors.deepOrangeAccent[200],
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.left,
                            initialValue: userData.nome,
                            validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                            onChanged: (val) => setState(() => _currentName = val),
                          ),
                          SizedBox(height: 30.0,),
                          //Phone Number
                          TextFormField(
                            decoration: InputDecoration(
                                contentPadding: new EdgeInsets.symmetric(vertical:0.0, horizontal: 0.0),
                                border:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(32.0)
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child:Icon(Icons.phone_android, color: Colors.deepOrange[200],),
                                ),
                                //icon: Icon(Icons.person),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Phone Number'
                            ),
                            cursorColor: Colors.deepOrangeAccent[200],
                            keyboardType: TextInputType.number,
                            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                            initialValue: userData.telemovel.toString(),
                            // passar para inteiro
                            onChanged: (val) => setState(() => _currentTelemovel = num.tryParse(val)),
                          ),
                          SizedBox(height: 30.0,),
                          //Fazer two button for gender
                          DropdownButtonFormField(
                            decoration: InputDecoration(labelText: 'Gender'),
                            value: _currentSexo ?? userData.sexo,
                            items: sexoList.map((sexo){
                              return DropdownMenuItem(
                                  value: sexo,
                                  child: Text('$sexo')
                              );
                            }).toList(),
                            onChanged: (val) => setState(() => _currentSexo = val),
                          ),
                          SizedBox(height: 30.0,),
                          //Date birthDay
                          FlatButton.icon(
                            icon: Icon(Icons.calendar_today, color: Colors.grey,),
                            label: _currentDtNasci!=null?Text('Birth '+ _currentDtNasci.day.toString()+"/"+_currentDtNasci.month.toString()+"/"+_currentDtNasci.year.toString(), style: TextStyle(color: Colors.grey)):Text('Birth '+ snapshot.data.dtNasci.day.toString()+"/"+snapshot.data.dtNasci.month.toString()+"/"+snapshot.data.dtNasci.year.toString(), style: TextStyle(color: Colors.grey)),
                            onPressed: () {
                              showDatePicker(

                                  context: context,
                                  initialDate: userData.dtNasci,
                                  firstDate: DateTime(1920),
                                  lastDate: DateTime(2021),

                              ).then((val){
                                setState(() {
                                  _currentDtNasci = val;
                                });
                              });
                            },
                          ),

                          //Button Save
                          RaisedButton(
                            color: Colors.deepOrangeAccent[200],
                            child: Text('Save', style: TextStyle(color: Colors.white),),
                            onPressed: () async {
                              if(_formKey.currentState.validate()){
                                await DatabaseService(uid: user.uid).updateUserData(
                                    snapshot.data.numSocio,
                                    filename ?? snapshot.data.img,
                                    _currentName ?? snapshot.data.nome,
                                    snapshot.data.email,
                                    _currentSexo ?? snapshot.data.sexo,
                                    snapshot.data.pass,
                                    _currentTelemovel ?? snapshot.data.telemovel,
                                    _currentDtNasci ?? snapshot.data.dtNasci,
                                    snapshot.data.aulasFrequentadas
                                );
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
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