import 'package:flutter/material.dart';
import 'package:gym_power/loading.dart';
import 'package:gym_power/models/user.dart';
import 'package:gym_power/service/database.dart';
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
  String _currentName, _currentPassword, _currentSexo;
  int _currentTelemovel;
  DateTime _currentDtNasci;
  final List<String> sexoList = ['F', 'M', 'Undetermined'];
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot){
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text("Account Settings", style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 18.0),),
                SizedBox(height: 20.0,),
                // update do nome
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  initialValue: userData.nome,
                  validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 10.0,),
                DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Gender'),
                  value: _currentSexo ?? userData.sexo,
                  items: sexoList.map((sexo){
                    return DropdownMenuItem(
                        value: sexo,
                        child: Text('$sexo sexoList')
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentSexo = val),
                ),
                SizedBox(height: 10.0,),

                TextFormField(
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  initialValue: userData.telemovel.toString(),
                  // passar para inteiro
                  onChanged: (val) => setState(() => _currentTelemovel = num.tryParse(val)),

                ),

                RaisedButton(
                  color: Colors.deepOrangeAccent,
                  child: Text('Save'),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                          snapshot.data.numSocio,
                          snapshot.data.img,
                          _currentName ?? snapshot.data.nome,
                          snapshot.data.email,
                          _currentSexo ?? snapshot.data.sexo,
                          snapshot.data.pass,
                          _currentTelemovel ?? snapshot.data.telemovel,
                          snapshot.data.dtNasci
                      );
                      Navigator.pop(context);
                    }
                  },
                ),


              ],
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