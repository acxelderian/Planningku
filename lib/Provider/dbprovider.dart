import 'package:dicoding/models/agenda.dart';
import 'package:flutter/material.dart';

import '../models/agenda.dart';
import '../utils/database_helper.dart';

class DbProvider extends ChangeNotifier{
  List<Agenda> _arrAgenda = [];
  late DatabaseHelper _dbHelper;
  List<Agenda> get agendas => _arrAgenda;
  DbProvider(){
    _dbHelper = DatabaseHelper();
  }
  Future<void> addAgenda(Agenda agenda) async{
    await _dbHelper.insertAgenda(agenda);
    notifyListeners();
  }
}