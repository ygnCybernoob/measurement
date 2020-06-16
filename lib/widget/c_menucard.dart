import 'package:flutter/material.dart';

class MenuCard extends StatefulWidget {
  final String text;
  final String iconPath;
  final VoidCallback onPress;
  final Key key;

  MenuCard({
    this.key,
    @required this.text,
    @required this.iconPath,
    @required this.onPress,
  }) : super(key: key);

  @override
  _MenuCardState createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.green,
        boxShadow: [
          BoxShadow(color: Color(0xff5f5f5f), blurRadius: 5, spreadRadius: 0)
        ],
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPress,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: widget.text,
                    child: Image.asset(
                      widget.iconPath,
                      height: 70,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 8,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      widget.text,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
