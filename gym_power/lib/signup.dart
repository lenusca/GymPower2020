import 'package:flutter/material.dart';
import 'package:gym_power/loading.dart';
import 'package:gym_power/service/auth.dart';
import 'package:gym_power/home.dart';
import 'package:gym_power/settings.dart';
import 'package:gym_power/signin.dart';

class SignUp extends StatefulWidget{
  static String tag = 'signup';
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp>{
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); //usada para validação
  bool loading = false;
  String error = '';
  String mail = '';
  String pass = '';

  @override
  Widget build(BuildContext context) {
    //logotipo
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 100.0, // tamanho da imagem
        child: Image.asset('assets/logo.png'),
      ),
    );

    //email
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
          hintText: 'Email',
          icon: new Icon(
            Icons.mail,
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)
          )
      ),
      //parte da base de dados
      validator: (val) => val.isEmpty ? "Enter an Email valid":null, //verifica se inseriu alguma coisa
      onChanged: (val){
        setState(() => mail = val);
      },
    );

    //username
    /*final username = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
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
    );*/

    // pass
    final password = TextFormField(
      autofocus: false,
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
        ),
      ),
      //parte da base de dados
      validator: (val) => val.length < 6 ? "Password should be at least 6 characters" : null, //obrigatorio ter no minimo 6 carateres
      onChanged: (val){
        setState(() => pass = val);
      },
    );

    //confirm pass
    final confirmpassword = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Confirm Password',
        icon: new Icon(
          Icons.lock,
          color: Colors.grey,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0)
        ),
      ),
      validator: (val) => val != pass ? "Unmatched password":null, //verifica se as passes coincidem
    );

    //botão
    final createButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        //quando cria a conta, depois volta para o login
        onPressed: () async{
          // currentstate vai buscar os valores dentro da form
          //validate vai validar, retorna true ou false
          if(_formKey.currentState.validate()){
            // vai buscar o utilizador
            setState(() {
              loading = true;
            });
            dynamic result = await _auth.registerWithEmailAndPassword(mail, pass);
            if(result == null) {
              setState(() {
                loading = false;
                error = 'Please supply a valid email';
              });
            }
            else{
              Navigator.of(context).pushNamed(Settings.tag);
            }

          }
        },
        padding: EdgeInsets.all(12),
        color: Colors.deepOrangeAccent[200],
        child: Text('Create Account', style: TextStyle(color: Colors.white),),
      ),
    );

    //voltar
    final  voltar = FlatButton(
      child: Text(
          'Back',
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.center
      ),
      onPressed: (){
        //widget.toggleView();
        Navigator.of(context).pushNamed(SignIn.tag);
      },
    );


    //fundo
    return  loading ? Loading() : Scaffold(

      backgroundColor: Colors.white,

      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height:20.0),
              email,
              SizedBox(height: 8.0),
              //username,
              SizedBox(height: 8.0),
              password,
              SizedBox(height: 8.0),
              confirmpassword,
              SizedBox(height: 24.0),
              // se não for inserido um email válido
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
              createButton,
              voltar
            ],
        ),

        ),
      ),

    );
  }
}