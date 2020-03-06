import 'package:gym_power/models/schedule.dart';


class Classes{
  String descricao;
  Schedule horario1, horario2;
  int lotacao;
  String nome, sala;

  Classes.fromMap(Map<String, dynamic> data){
    descricao = data['descricao'];
    horario1 = data['horario'][0];
    horario2 = data['horario'][1];
    lotacao = data['limite'];
    nome = data['nome'];
    sala = data['sala'];
  }

}