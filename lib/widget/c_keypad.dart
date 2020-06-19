import 'package:flutter/material.dart';
import 'package:measurement/widget/c_numberfield.dart';

enum KeyType { digit, point, negative, clear, delete }

class Keypad extends StatelessWidget {
  final void Function(String value, KeyType keyType) onPressed;
  final KeyPadController keyPadController;
  final bool sign;
  final bool isPortrait;

  Keypad(
      {this.onPressed,
      this.keyPadController,
      this.sign = false,
      this.isPortrait});

  Widget vdivider() =>
      VerticalDivider(color: Colors.white, thickness: 2, width: 0);

  Widget hdivider() => Divider(color: Colors.white, thickness: 2, height: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isPortrait ? 240 : MediaQuery.of(context).size.height,
      width: isPortrait ? MediaQuery.of(context).size.width : 260,
      color: Colors.green,
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            KeyRow(<Widget>[
              C_Key('C', onPressed, keytype: KeyType.clear),
              vdivider(),
              C_Key('⌫', onPressed, keytype: KeyType.delete),
              vdivider(),
            ]),
            hdivider(),
            KeyRow(<Widget>[
              C_Key('1', onPressed),
              vdivider(),
              C_Key('2', onPressed),
              vdivider(),
              C_Key('3', onPressed),
              vdivider(),
            ]),
            hdivider(),
            KeyRow(<Widget>[
              C_Key('4', onPressed),
              vdivider(),
              C_Key('5', onPressed),
              vdivider(),
              C_Key('6', onPressed),
              vdivider(),
            ]),
            hdivider(),
            KeyRow(<Widget>[
              C_Key('7', onPressed),
              vdivider(),
              C_Key('8', onPressed),
              vdivider(),
              C_Key('9', onPressed),
              vdivider(),
            ]),
            hdivider(),
            KeyRow(<Widget>[
              sign
                  ? C_Key('+/-', onPressed, keytype: KeyType.negative)
                  : Spacer(),
              vdivider(),
              C_Key('0', onPressed),
              vdivider(),
              C_Key('.', onPressed, keytype: KeyType.point),
              vdivider(),
            ]),
            hdivider(),
          ],
        ),
      ),
    );
  }
}

class KeyRow extends StatelessWidget {
  const KeyRow(this.keys);

  final List<Widget> keys;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: keys,
      ),
    );
  }
}

class C_Key extends StatelessWidget {
  const C_Key(this.text, this.onPressed, {this.keytype = KeyType.digit});

  final KeyType keytype;
  final String text;

  final void Function(String value, KeyType keyType) onPressed;

  @override
  Widget build(BuildContext context) {
//    final Orientation orientation = MediaQuery.of(context).orientation;
    return Expanded(
      child: FlatButton(
        onPressed: () {
          onPressed(this.text, this.keytype);
        },
        child: Center(
          child: Text(
            text,
            style: TextStyle(
//                fontSize: (orientation == Orientation.portrait) ? 32.0 : 24.0
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class KeyPadController {
  List<C_NumberFieldController> c_numberFieldCtrlList;

  void pressedKey(String v, KeyType keyType) {
    C_NumberFieldController _current;

    c_numberFieldCtrlList.forEach((v) {
      if (v.focused) _current = v;
    });

    String text = _current.newValue ? '0' : _current.value;
    _current.newValue = false;

    switch (keyType) {
      case KeyType.digit:
        if (text == '0') {
          text = v;
        } else if (text == '-0') {
          text = '-' + v;
        } else {
          text += v;
        }
        break;
      case KeyType.point:
        if (!text.contains('.')) {
          text += '.';
        }
        break;
      case KeyType.negative:
        if (!text.contains('-')) {
          text = '-' + text;
        } else {
          text = text.replaceFirst('-', '');
        }
        break;
      case KeyType.clear:
        text = '0';
        break;
      case KeyType.delete:
        if (text.length == 1) {
          text = '0';
        } else if (text.contains('-0')) {
          text = '0';
        } else if (text.contains('-') && text.length == 2) {
          text = '-0';
        } else {
          text = text.substring(0, text.length - 1);
        }
        break;
    }

    _current.value = text;
  }
}
