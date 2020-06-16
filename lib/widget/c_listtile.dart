import 'package:flutter/material.dart';

class C_ListTile extends StatelessWidget {
  final VoidCallback copyPressed;
  final String text;

  C_ListTile({this.text, this.copyPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: IconButton(
        tooltip: 'Copy',
        color: Colors.green,
        icon: Icon(Icons.content_copy),
        onPressed: this.copyPressed,
      ),
      leading: Icon(
        Icons.arrow_right,
        color: Colors.green,
      ),
      title: Text(
        this.text,
        style: TextStyle(
          color: Colors.green,
        ),
      ),
    );
  }
}
