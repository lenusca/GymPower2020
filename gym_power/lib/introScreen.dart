import 'dart:io';
import 'dart:math';
import 'package:path/path.dart' as Path;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gym_power/service/database.dart';
import 'package:gym_power/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:gym_power/models/user.dart';
import 'package:provider/provider.dart';
import 'package:gym_power/home.dart';

import 'loading.dart';

class IntroScreen extends StatefulWidget {
  static String tag = "introscreen";
  final userID;

  IntroScreen({Key key, this.userID}) : super(key: key);
  
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();
  final _formKey = GlobalKey<FormState>();
  Color _iColorFemale = Colors.deepOrange[200];
  Color _iColorMale = Colors.deepOrange[200];
  bool selectF = false, selectM = false;

  //firebase
  Random rand = new Random();
  File _img;
  String name="User", sexo='M', filename;
  int telemovel=0, numSocio; 
  DateTime _dtNasci=null;
  double height=1.0, weight=0.0, imc;
  String _result="";

  void __iconColorFemale(bool select) {
    if(select) {_iColorFemale = Colors.deepOrangeAccent[200]; }
    else{ _iColorFemale = Colors.deepOrange[200]; }
  }

  void __iconColorMale(bool select) {
    if(select) {_iColorMale = Colors.deepOrangeAccent[200]; }
    else{ _iColorMale = Colors.deepOrange[200]; }
  }

  String calculateImc(double weight, double height) {
    height = height/100;
    double imc = weight / (height * height);

    setState(() {
      _result = "IMC = ${imc.toStringAsPrecision(2)}\n";
      if (imc < 18.6)
        _result += "Abaixo do peso";
      else if (imc < 25.0)
        _result += "Peso ideal";
      else if (imc < 30.0)
        _result += "Levemente acima do peso";
      else if (imc < 35.0)
        _result += "Obesidade Grau I";
      else if (imc < 40.0)
        _result += "Obesidade Grau II";
      else
        _result += "Obesidade Grau IIII";
    });
    return _result;
  } 

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w700),
      titlePadding: EdgeInsets.only(top:80.0),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.only(top:50.0),
    );

    Future uploadImage() async{
      StorageReference ref = FirebaseStorage.instance.ref().child(filename);
      StorageUploadTask upload = ref.putFile(_img);
      StorageTaskSnapshot taskSnapshot = await upload.onComplete;
      setState(() {
        //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
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
        if(!snapshot.hasData){
          Loading();
        }
        else{
          UserData userData = snapshot.data; 
          return Form(
            key: _formKey,
            child: IntroductionScreen(
            pages: [
        //Page welcome  
        PageViewModel(
          title: "Welcome", 
          bodyWidget: Column(
            children: <Widget>[
              Align( child: Image.asset('assets/logo.png', width: 300.0, height: 300.0,), alignment: Alignment.bottomCenter,),
              Text("Let's start!", style: TextStyle(fontSize: 22.0,),),
            ],
          ),
          decoration: pageDecoration,
        ),
        //Page Image
        PageViewModel(
          title: "Avatar",
          bodyWidget: Column(children: <Widget>[
            SizedBox(height: 20,),
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
          ],),
          decoration: pageDecoration,
        ),
        //Page Select Sex
        PageViewModel(
          title: "What's your gender?",
          bodyWidget: Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(top: 400.0, )),
              //Female
              IconButton(
                padding: EdgeInsets.only(left: 0, right: 0),
                icon: FaIcon(FontAwesomeIcons.female,),
                iconSize: 145,
                color: _iColorFemale,
                onPressed: () {
                  setState(() {
                      selectF = !selectF;
                      selectM = false;
                      __iconColorFemale(selectF);
                      __iconColorMale(selectM);
                      sexo = 'F';
                    },
                  );
                },
              ),
             //Male
             IconButton(
                padding: EdgeInsets.only(left: 0, right: 0),
                icon: FaIcon(FontAwesomeIcons.male),
                iconSize: 145,
                color: _iColorMale,
                onPressed: () {  
                  setState(() {
                      selectM = !selectM;
                      selectF = false;
                      __iconColorMale(selectM);
                      __iconColorFemale(selectF);
                      sexo = 'M';
                    },
                  );
                }, 
              ),
            ],
          ),
          decoration: pageDecoration,
        ),
        //Page Name, PhoneNumber, bithDay
        PageViewModel(
          title: "Information about you", 
          decoration: pageDecoration,
          bodyWidget: Column(
              children: <Widget> [
                Padding(padding: EdgeInsets.only(top: 80.0, )),
                //Name
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
                    filled: false,
                    hintText: 'First and Last Name',
                    labelText: 'Name',
                    labelStyle: TextStyle(inherit: true),
                  ),
                  cursorColor: Colors.deepOrangeAccent[200],
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.left,
                  initialValue: '',
                  onChanged: (val) => setState(() => name = val),
                  validator: (val) => val.isEmpty ? 'Please enter a name' : null,
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
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Phone Number'
                  ),
                  cursorColor: Colors.deepOrangeAccent[200],
                  keyboardType: TextInputType.number,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  onChanged: (val) => setState(() => telemovel = num.tryParse(val)),
                ),
                
                //Birthday Date
                SizedBox(height: 30.0),
                FlatButton.icon(
                  icon: Icon(Icons.calendar_today, color: Colors.deepOrange[200],),
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0),side: BorderSide(color: Colors.grey, width: 1)),
                  padding: EdgeInsets.symmetric(vertical:15.0, horizontal: 60.0),
                  label: _dtNasci!=null?Text('Birth '+ _dtNasci.day.toString()+"/"+_dtNasci.month.toString()+"/"+_dtNasci.year.toString(), 
                  style: TextStyle(color: Colors.grey,fontSize: 18.0,)):Text('Birth '+ snapshot.data.dtNasci.day.toString()+"/"+snapshot.data.dtNasci.month.toString()+"/"+snapshot.data.dtNasci.year.toString(), 
                    style: TextStyle(color: Colors.grey, fontSize: 18.0)),
                  onPressed: () {
                    showDatePicker(
                        context: context,
                        initialDate: userData.dtNasci,
                        firstDate: DateTime(1920),
                        lastDate: DateTime(2021),
                    ).then((val){
                      setState(() {
                        _dtNasci = val;
                        numSocio=_dtNasci.day+rand.nextInt(1000);
                      });
                    });
                  },
                ),
              ],
            ),
        ),
        //Page config peso e altura
        PageViewModel(
          title: "Health Information", 
          decoration: pageDecoration,
          bodyWidget: Column(
              children: <Widget> [
                Padding(padding: EdgeInsets.only(top: 80.0, )),
                 //Altura
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
                      child:FaIcon(FontAwesomeIcons.rulerVertical, color: Colors.deepOrange[200]),
                    ),
                    filled: false,
                    suffix: Padding(padding: EdgeInsets.only(right: 30.0), child: Text('cm'),),
                    labelText: 'Height',
                    labelStyle: TextStyle(inherit: true),
                  ),
                  cursorColor: Colors.deepOrangeAccent[200],
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.number,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  onChanged: (val) => setState(() => height = double.parse(val)),
                ),
                 SizedBox(height: 30.0,),
                //Peso
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
                      child:FaIcon(FontAwesomeIcons.weight, color: Colors.deepOrange[200]),
                    ),
                    filled: false,
                    suffix: Padding(padding: EdgeInsets.only(right: 30.0), child: Text('Kg'),),
                    labelText: 'Weight',
                    labelStyle: TextStyle(inherit: true),
                  ),
                  cursorColor: Colors.deepOrangeAccent[200],
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.number,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  onChanged: (val) => setState(() => weight = double.parse(val)),
                ),
                SizedBox(height: 30.0,),
                RaisedButton(
                  color: Colors.deepOrangeAccent[200],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 70.0),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _result = calculateImc(weight, height);
                    }
                  },
                  child: Text('Calcular IMC', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(height: 30.0,),
                Text(_result, style: TextStyle(fontSize: 20.0, color: Colors.grey,),textAlign: TextAlign.center,), 
              ],
          )
        ),
      ],
      onDone: () async {
        if(_formKey.currentState.validate()){
          await DatabaseService(uid: user.uid).updateUserData(
              numSocio ?? snapshot.data.numSocio,
              filename ?? snapshot.data.img,
              name ?? snapshot.data.nome,
              snapshot.data.email,
              sexo ?? snapshot.data.sexo,
              snapshot.data.pass,
              telemovel ?? snapshot.data.telemovel,
              _dtNasci ?? snapshot.data.dtNasci
          );
         Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => Home()),);
        }
      },
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: Color(0xFFFF6E40),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    ),
          );
        }
        }
    );
  }
}
