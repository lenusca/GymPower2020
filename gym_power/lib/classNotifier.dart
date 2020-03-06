import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:gym_power/models/classes.dart';

class classNotifier with ChangeNotifier{
  List<Classes> _listClasses = [];
  Classes _currentClass;
  UnmodifiableListView<Classes> get classesList => UnmodifiableListView(_listClasses);

  Classes get currentClass => _currentClass;

  set classList(List<Classes> classList){
    _listClasses = classList;
    notifyListeners();
  }

  set currentClass(Classes clas){
    _currentClass = clas;
    notifyListeners();
  }
}