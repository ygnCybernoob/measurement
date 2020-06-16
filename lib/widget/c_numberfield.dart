import 'package:flutter/material.dart';

class C_NumberField extends StatefulWidget {
  final VoidCallback onPressed;
  final C_NumberFieldController controller;

  C_NumberField({this.onPressed, this.controller});

  @override
  _C_NumberFieldState createState() => _C_NumberFieldState();
}

class _C_NumberFieldState extends State<C_NumberField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_event);
  }

  void _event() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: widget.controller.focused ? Colors.green : Colors.black54,
          width: 3,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            widget.controller.focused = true;
            widget.onPressed();
          },
          child: SingleChildScrollView(
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Align(
              child: Text(
                widget.controller._value,
                style: TextStyle(
                  color:
                      widget.controller.focused ? Colors.green : Colors.black54,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_event);
    super.dispose();
  }
}

class C_NumberFieldController extends ChangeNotifier {
  ///constructor
  C_NumberFieldController({String value = '', bool focused = false})
      : _value = value,
        _focused = focused;
  bool _newValue = true;

  bool get newValue => this._newValue;

  set newValue(bool v) {
    _newValue = v;
  }

  bool _focused;

  bool get focused => this._focused;

  set focused(bool v) {
    ///if already focused
    if (v == _focused) return;
    _focused = v;
    _newValue = true;
    notifyListeners();
  }

  String _value;

  String get value => this._value;

  set value(String v) {
    _value = v;
    notifyListeners();
  }
}
