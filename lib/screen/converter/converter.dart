import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';
import 'package:measurement/model/history.dart' as model;
import 'package:measurement/model/measurement.dart';
import 'package:measurement/model/menu.dart';
import 'package:measurement/screen/converter/notifier/converter_notifier.dart';
import 'package:measurement/screen/history/history.dart';
import 'package:measurement/screen/history/notifier/history_notifier.dart';
import 'package:measurement/util.dart';
import 'package:measurement/widget/c_dropdown.dart';
import 'package:measurement/widget/c_keypad.dart';
import 'package:measurement/widget/c_numberfield.dart';
import 'package:provider/provider.dart';

class Converter extends StatelessWidget {
  final Menu menu;
  final _histNotifier = HistoryNotifier();

  final _nfCtrl1 = C_NumberFieldController(value: '0', focused: true);
  final _nfCtrl2 = C_NumberFieldController(value: '0');
  final _kpCtrl = KeyPadController();

  Converter({this.menu}) {
    _kpCtrl.c_numberFieldCtrlList = [
      _nfCtrl1,
      _nfCtrl2,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ConverterNotifier(menu.path),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Hero(
                tag: menu.text.tr(),
                child: Image.asset(
                  menu.iconPath,
                  height: 30,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 5),
              Text(
                menu.text.tr(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.history),
              onPressed: () => Util.navigate(context, widget: History()),
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxHeight >= constraints.maxWidth / 2) {
              return Column(
                children: <Widget>[
                  Spacer(flex: 1),
                  _unitEntry(context),
                  Spacer(flex: 2),
                  _keyPad(true),
                ],
              );
            } else {
              return Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Spacer(flex: 1),
                        _unitEntry(context),
                        Spacer(flex: 2),
                      ],
                    ),
                  ),
                  _keyPad(false),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _keyPad(bool isPortrait) => Consumer<ConverterNotifier>(
        builder: (context, notifier, child) {
          return Keypad(
            isPortrait: isPortrait,
            sign: menu.sign,
            keyPadController: _kpCtrl,
            onPressed: (value, keyType) {
              _kpCtrl.pressedKey(value, keyType);

              onValueChanged(notifier);
            },
          );
        },
      );

  Widget _unitEntry(BuildContext context) {
    return Column(
      children: <Widget>[
        Consumer<ConverterNotifier>(
          builder: (context, notifier, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                C_DropDown(
                  items: notifier.modelList
                      .map(
                        (v) => DropdownMenuItem<MeasurementModel>(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(v.unit),
                          ),
                          value: v,
                        ),
                      )
                      .toList(),
                  value: notifier.model1,
                  onChanged: (model) {
                    notifier.model1 = model;
                    onValueChanged(notifier);
                  },
                ),
                _arrow(),
                C_DropDown(
                  items: notifier.modelList
                      .map(
                        (v) => DropdownMenuItem<MeasurementModel>(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(v.unit),
                          ),
                          value: v,
                        ),
                      )
                      .toList(),
                  value: notifier.model2,
                  onChanged: (model) {
                    notifier.model2 = model;
                    onValueChanged(notifier);
                  },
                ),
              ],
            );
          },
        ),
        SizedBox(height: 10),
        Consumer<ConverterNotifier>(
          builder: (context, notifier, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                C_NumberField(
                  controller: _nfCtrl1,
                  onPressed: () {
                    _nfCtrl2.focused = false;
                  },
                ),
                _arrow(),
                C_NumberField(
                  controller: _nfCtrl2,
                  onPressed: () {
                    _nfCtrl1.focused = false;
                  },
                ),
              ],
            );
          },
        ),
        SizedBox(height: 20),
        Builder(
          builder: (context) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FlatButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: () async {
                    final notifier =
                        Provider.of<ConverterNotifier>(context, listen: false);

                    String str =
                        "${notifier.value1} ${notifier.model1.unit} = ${notifier.value2} ${notifier.model2.unit}";

                    _histNotifier.addHistory(
                      model.History(history: str),
                    );

                    FlutterClipboardManager.copyToClipBoard(str).then((result) {
                      final snackBar = SnackBar(
                        content: Text('Copied to Clipboard!'),
                        duration: Duration(seconds: 1),
                      );
                      Scaffold.of(context).showSnackBar(snackBar);
                    });
                  },
                  child: Text('Copy'),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  void onValueChanged(ConverterNotifier notifier) {
    if (_nfCtrl1.focused) {
      notifier.convertV1ToV2(double.parse(_nfCtrl1.value));
      _nfCtrl2.value = notifier.value2.toString();
    } else if (_nfCtrl2.focused) {
      notifier.convertV2ToV1(double.parse(_nfCtrl2.value));
      _nfCtrl1.value = notifier.value1.toString();
    }
  }

  Widget _arrow() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Image.asset(
          'assets/icons/bi_direction_arrow.png',
          width: 25,
          color: Colors.green,
        ),
      );
}
