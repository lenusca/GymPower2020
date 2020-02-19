import 'package:flutter/material.dart';
import 'package:gym_power/home.dart';
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
            print(pass);
            print(mail);
            if(_formKey.currentState.validate()){
              dynamic result = await _auth.signInWithEmailAndPassword(mail, pass);
              // vai buscar o utilizador
              if(result == null) {
                setState(() {
                  error = 'User not valid! ';
                });
              }
              else{
                Navigator.of(context).pushNamed(Home.tag);
              }
            }
          },
          padding: EdgeInsets.all(12),
          color: Colors.deepOrange,
          child: Text('Login', style: TextStyle(color: Colors.white)),
        )
    );

    // esquecer a pass
    final createaccountLabel = FlatButton(
      child: Text(
          'Create Account',
          style: TextStyle(color: Colors.deepOrange),
          textAlign: TextAlign.center
      ),
      onPressed:(){
        Navigator.of(context).pushNamed(SignUp.tag);
      },
    );

    // pop up para o forgot password

    //fundo
    return Scaffold(
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
              loginButton,
              createaccountLabel,
            ],
        ),
        ),
      ),
    );
  }
}