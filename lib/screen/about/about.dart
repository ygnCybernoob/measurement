import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:measurement/main.dart';
import 'package:measurement/model/developer_info.dart';
import 'package:url_launcher/url_launcher.dart' as url;

class About extends StatelessWidget {
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
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/logo/measurement.png',
                        height: 120,
                      ),
                      Text(
                        appTitle.tr(),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        appVersion,
                        style: TextStyle(color: Colors.green),
                      ),
                      Divider(),
                      Text(
                        'about.desp'.tr(),
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 14.5,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Free Icons from https://www.iconfinder.com. Thank You!',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Unit's data are referenced from Microsoft Calculator.",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'If you encounter any issue, please kindly email to cybernoob.ygn@gmail.com',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(),
                      _aboutDeveloper(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () => Navigator.pop(context),
                child: Text('about.close'.tr()),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _aboutDeveloper() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Developer: ',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Kyaw Nyein Phyo (Cybernoob)',
                style: TextStyle(color: Colors.green, fontSize: 14.5),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: developerInfos.map((f) => _contact(f)).toList(),
          )
        ],
      ),
    );
  }

  Widget _contact(DeveloperInfo info) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: <Widget>[
          Text(
            '${info.label}: ',
            style: TextStyle(
              fontSize: 15,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () async {
              bool canLaunch = await url.canLaunch(info.urlStr);
              if (canLaunch)
                url.launch(info.urlStr);
              else
                url.launch(info.backup);
            },
            child: Text(
              info.text,
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 14.5,
                  decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );
  }
}
