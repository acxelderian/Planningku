import 'package:dicoding/models/agenda.dart';
import 'package:flutter/material.dart';

import '../utils/database_helper.dart';

class DbProvider extends ChangeNotifier{
  List<Agenda> _arrAgenda = [];
  late DatabaseHelper _dbHelper;
  List<Agenda> get agendas => _arrAgenda;

  DbProvider(){
    _dbHelper = DatabaseHelper();
    _getAllAgendas();
  }
  void _getAllAgendas() async {
    _arrAgenda = await _dbHelper.getAgendas();
    notifyListeners();
  }
  Future<void> addAgenda(Agenda agenda) async{
    await _dbHelper.insertAgenda(agenda);
    _getAllAgendas();
  }
  Future<Agenda> getAgendaById(int id) async{
    return await _dbHelper.getAgendaById(id);
  }

  Future <List<Agenda>> getAgendas() async {
    _getAllAgendas();
    return _arrAgenda;
  }

  Future<void> deleteAgenda(int id) async{
    await _dbHelper.deleteAgenda(id);
    _getAllAgendas();
  }

  Future<bool> isAgendaFavorite(int id) async{
    Agenda? agenda = await _dbHelper.getAgendaByIdCanBeNull(id);
    return agenda != null;
  }
}