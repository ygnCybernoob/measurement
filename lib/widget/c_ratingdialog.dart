import 'package:flutter/material.dart';

class C_RatingDialog extends StatelessWidget {
  final VoidCallback rate, remindLater, never;

  C_RatingDialog({this.rate, this.remindLater, this.never})
      : assert(rate != null || remindLater != null || never != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      child: Dialog(
        backgroundColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 75,
              child: Center(
                child: Text(
                  'Do you want to rate this app?',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Divider(height: 0, thickness: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  MaterialButton(
                    textColor: Colors.green,
                    onPressed: () {
                      rate();
                      Navigator.pop(context);
                    },
                    child: Text('Rate'),
                  ),
                  MaterialButton(
                    textColor: Colors.green,
                    onPressed: () {
                      remindLater();
                      Navigator.pop(context);
                    },
                    child: Text('Remind Later'),
                  ),
                  MaterialButton(
                    textColor: Colors.red,
                    onPressed: () {
                      never();
                      Navigator.pop(context);
                    },
                    child: Text('Never'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
