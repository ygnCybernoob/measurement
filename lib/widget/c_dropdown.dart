import 'package:flutter/material.dart';

class C_DropDown<T> extends StatelessWidget {
  final void Function(T value) onChanged;
  final List<DropdownMenuItem<T>> items;
  final T value;
  final Widget hint;

  C_DropDown({
    @required this.items,
    @required this.onChanged,
    this.value,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.green,
          width: 3,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: DropdownButton<T>(
            items: items,
            isExpanded: true,
            iconEnabledColor: Colors.green,
            iconSize: 35,
            style: TextStyle(
              color: Colors.green,
              fontSize: 16.5,
            ),
            underline: Container(),
            onChanged: onChanged,
            hint: hint,
            value: value,
          ),
        ),
      ),
    );
  }
}
