import 'package:measurement/service/database_service.dart';

class History implements IModel {
  @override
  int id;

  final String history;

  History({this.id, this.history});

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'history': history,
    };
  }
}
