import 'package:flutter/material.dart';
import 'package:measurement/model/general_model.dart';
import 'package:measurement/model/history.dart';
import 'package:measurement/service/database_service.dart';

class HistoryNotifier extends ChangeNotifier {
  DatabaseService _dbService = DatabaseService();

  DataState _dataState = DataState.operating;

  DataState get dataState => this._dataState;

  List<History> _historyList = [];

  List<History> get historyList => this._historyList;

  Future<void> addHistory(History history) async {
    try {
      int no = await _dbService.insert(tableName: 'history', model: history);

//      assert(no != 1, 'History has not inserted');
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  Future<void> clearHistory() async {
    try {
      _dataState = DataState.operating;
      _historyList.clear();
      notifyListeners();

      _dbService.deleteAll(tableName: 'history');

      _dataState = DataState.finished;
      notifyListeners();
    } catch (ex) {
      debugPrint(ex.toString());

      _dataState = DataState.error;
      notifyListeners();
    }
  }

  Future<void> retrieveHistory() async {
    try {
      _dataState = DataState.operating;
      _historyList.clear();
      notifyListeners();

      final list = await _dbService.getMapListWithOrder(
          tableName: 'history', orderBy: 'id');

      _historyList.addAll(
        list.map(
          (f) => History(
            id: f['id'],
            history: f['history'],
          ),
        ),
      );

      _dataState = DataState.finished;
      notifyListeners();
    } catch (ex) {
      debugPrint(ex.toString());

      _dataState = DataState.error;
      notifyListeners();
    }
  }

  void copyToClipboard(String data) {}
}
