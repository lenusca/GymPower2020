class User{
  final String uid;
  User({this.uid});
}

class UserData {
  final String uid;
  final int numSocio, telemovel;
  final String img;
  final DateTime dtNasci;
  final String nome, email, sexo, pass;

  UserData({ this.uid, this.numSocio, this.img, this.nome, this.email, this.sexo, this.pass, this.telemovel, this.dtNasci});
}