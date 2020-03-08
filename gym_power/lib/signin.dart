import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gym_power/home.dart';
import 'package:gym_power/loading.dart';
import 'package:gym_power/service/auth.dart';
import 'package:gym_power/signup.dart';

class SignIn extends StatefulWidget {
  static String tag = "signin";

  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn>{
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); //usada para validação
  bool loading = false;
  String mail = '';
  String pass = '';
  String error = '';

  @override
  Widget build(BuildContext context){
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor : Colors.transparent,
        radius: 100.0, //tamanho da imagem
        child: Image.asset("assets/logo.png"),
      ),
    );

    // para pedir o email
    final username = TextFormField(
        keyboardType: TextInputType.text,
        autofocus: false,
        //initialValue: 'Helena',
        decoration: InputDecoration(
            hintText: 'Username',
            icon: new Icon(
              Icons.account_circle,
              color: Colors.grey,
            ),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0)
            )
        ),
      validator: (val) => val.isEmpty ? "Enter an Email valid":null, //verifica se inseriu alguma coisa
      onChanged: (val){
        setState(() => mail = val);
      },
    );

    // para pedir a pass
    final password = TextFormField(
        autofocus: false,
        //initialValue: 'some password',
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            ),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0)
            )
        ),
      validator: (val) => val.length < 6 ? "Password should be at least 6 characters" : null, //obrigatorio ter no minimo 6 carateres
      onChanged: (val){
        setState(() => pass = val);
      },
    );

    // botão
    final loginButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          //quando carregado vai para o menu
          onPressed: () async{
            // currentstate vai buscar os valores dentro da form
            //validate vai validar, retorna true ou false
            if(_formKey.currentState.validate()){
              setState(() => loading = true);
              dynamic result = await _auth.signInWithEmailAndPassword(mail, pass);
              // vai buscar o utilizador
              if(result == null) {
                setState(() {
                  error = 'User not valid! ';
                  loading = false;
                });
              }
              else{
                Navigator.of(context).pushNamed(Home.tag);
              }
            }
          },
          padding: EdgeInsets.all(12),
          color: Colors.deepOrangeAccent[200],
          child: Text('Login', style: TextStyle(color: Colors.white)),
        )
    );

    // criar conta
    final createaccountLabel = FlatButton(
      child: Text(
          'Create Account',
          style: TextStyle(color: Colors.deepOrangeAccent[200]),
          textAlign: TextAlign.center
      ),
      onPressed:(){
        Navigator.of(context).pushNamed(SignUp.tag);
      },
    );

    createAlertDialog(BuildContext context) {
      TextEditingController customController = new TextEditingController();
      return showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text('Email: '),
          content: TextField(
            controller: customController,
            onChanged: (val){

              setState(() => mail = val);
            },
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Text('SEND', style: TextStyle(color: Colors.deepOrange)),
              //sair do popup
              onPressed: () {
                _auth.sendPasswordResetEmail(mail);
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ],
        );
      });
    }

    // esquecer a pass
    final forgotLabel = FlatButton(
      child: Text(
          'Forgot password?',
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.center
      ),
      onPressed:(){
        createAlertDialog(context);
      },
    );

    // pop up para o forgot password

    //fundo
    // se o loading for true fica a pensar, se não mostra tudo
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            // ui components
            children: <Widget>[
              logo,
              SizedBox(height: 20.0),
              username,
              SizedBox(height: 8.0),
              password,
              SizedBox(height: 24.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
              forgotLabel,
              loginButton,
              createaccountLabel,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton.icon(
                      onPressed: () async{
                        dynamic result = await _auth.signInWithGoogle();
                        if(result == null) {
                          setState(() {
                            error = 'User not valid! ';
                            loading = false;
                          });
                        }
                        else{
                          Navigator.of(context).pushNamed(Home.tag);
                        }
                      },
                      icon: Icon(FontAwesomeIcons.google, color: Colors.grey,),
                      label: Text("")
                  ),
                  FlatButton.icon(
                      onPressed: () async{
                        dynamic result = await _auth.signInWithFacebook();
                        if(result == null) {
                          setState(() {
                            error = 'User not valid! ';
                            loading = false;
                          });
                        }
                        else{
                          Navigator.of(context).pushNamed(Home.tag);
                        }
                      },
                      icon: Icon(FontAwesomeIcons.facebook, color: Colors.grey,),
                      label: Text("")
                  )
                ],
              ),
            ],
        ),
        ),
      ),
    );
  }
}