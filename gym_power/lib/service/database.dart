import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gym_power/models/user.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  // vai buscar os dados a nossa firebase, se não existir na base de dados ele cria a mesma
  final CollectionReference user = Firestore.instance.collection('users');

  // chamada quand é registrado e quando ha update dos dados
  Future<void> updateUserData(int numSocio, Image img, String nome, String email, String sexo, String pass, int telemovel, DateTime dtNasci) async{
    return await user.document(uid).setData({
      'numSocio': numSocio,
      'img': img,
      'nome': nome,
      'email': email,
      'sexo': sexo,
      'pass': pass,
      'telemovel': telemovel,
      'dtNasci': dtNasci
    });
  }

  // dados que queremos ir buscar
  UserData _userDataFromSnapshot(DocumentSnapshot doc){
    // vai buscar cada dado de um utilizador
    return UserData(
      uid: uid,
      numSocio: doc.data['numSocio'],
      img: doc.data['img'],
      nome: doc.data['nome'],
      email: doc.data['email'],
      sexo: doc.data['sexo'],
      pass: doc.data['pass'],
      telemovel: doc.data['telemovel'],
      dtNasci: doc.data['dtNasci']
    );
  }

  // get user doc stream
  Stream<UserData> get userData{
    return user.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}