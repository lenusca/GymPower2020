import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:gym_power/models/user.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  // vai buscar os dados a nossa firebase, se não existir na base de dados ele cria a mesma
  final CollectionReference user = Firestore.instance.collection('users');


  // chamada quand é registrado e quando ha update dos dados
  Future<void> updateUserData(int numSocio, String img, String nome, String email, String sexo, String pass, int telemovel, DateTime dtNasci) async{
    // para ir buscar a imagem

    String urlImage = "";
    if(img.contains("https://firebasestorage")){
      urlImage = img;
    }

    else{
      StorageReference ref = FirebaseStorage.instance.ref().child(img);
      var url = await ref.getDownloadURL();
      urlImage = url.toString();
    }
    // colocar como timestamp datetime
    Timestamp birth = Timestamp.fromDate(dtNasci);
    return await user.document(uid).setData({
      'numSocio': numSocio,
      'img': urlImage,
      'nome': nome,
      'email': email,
      'sexo': sexo,
      'pass': pass,
      'telemovel': telemovel,
      'dtNasci': birth
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
      dtNasci: doc.data['dtNasci'].toDate()
    );
  }

  // get user doc stream
  Stream<UserData> get userData{
    return user.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}