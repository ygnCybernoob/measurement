import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:measurement/model/measurement.dart';

class ConverterNotifier extends ChangeNotifier {
  final List<MeasurementModel> modelList = [];
  final bool _isTemperature;

  format(num n) => n == n.truncate() ? n.truncate() : n;

  double _value1 = 0;
  double _value2 = 0;

  get value1 {
    return format(_value1);
  }

  get value2 {
    return format(_value2);
  }

  MeasurementModel _model1;
  MeasurementModel _model2;

  MeasurementModel get model1 => _model1;

  MeasurementModel get model2 => _model2;

  set model1(MeasurementModel v) {
    _model1 = v;
    notifyListeners();
  }

  set model2(MeasurementModel v) {
    _model2 = v;
    notifyListeners();
  }

  ConverterNotifier(String path)
      : _isTemperature = path.toLowerCase() == 'temperature' {
    retrieveData(path);
  }

  Future<void> retrieveData(String path) async {
    final rawJs = await rootBundle.loadString('assets/json/measurement.json');
    Map<String, dynamic> map = json.decode(rawJs)[path];
    assert(map != null);
    map.forEach((k, v) {
      modelList.add(MeasurementModel(unit: k, value: v));
    });
    model1 = modelList[0];
    model2 = modelList[0];
  }

  double _calculateTemp(double value, MeasurementModel from, MeasurementModel to) {
    if (from.unit == 'Celsius') {
      switch (to.unit) {
        case 'Fahrenheit':
          return 9 / 5 * value + 32;
        case 'Kelvin':
          return value + 273;
      }
    } else if (from.unit == 'Fahrenheit') {
      switch (to.unit) {
        case 'Celsius':
          return 5 / 9 * (value - 32);
        case 'Kelvin':
          return 5 / 9 * (value - 32) + 273;
      }
    } else if (from.unit == 'Kelvin') {
      switch (to.unit) {
        case 'Celsius':
          return value - 273;
        case 'Fahrenheit':
          return 9 / 5 * (value - 273) + 32;
      }
    }
    return 0;
  }

  void convertV1ToV2(double value) {
    _value1 = value;

    if (model1.unit == model2.unit) {
      _value2 = _value1;
    } else {
      _value2 = _isTemperature
          ? _calculateTemp(value, model1, model2)
          : _value1 / model2.value * model1.value;
    }

    notifyListeners();
  }

  void convertV2ToV1(double value) {
    _value2 = value;

    if (model1.unit == model2.unit) {
      _value1 = _value2;
    } else {
      _value1 = _isTemperature
          ? _calculateTemp(value, model2, model1)
          : _value2 / model1.value * model2.value;
    }

    notifyListeners();
  }
}
