import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Language extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Language'),
      ),
      body: ListView(
        children: supportLanguage.map(
          (lan) {
            return ListTile(
              onTap: () {
                EasyLocalization.of(context).locale =
                    Locale(lan.codeL, lan.codeC);
              },
              title: Text(lan.name),
              leading: Icon(Icons.arrow_right),
              trailing:
                  EasyLocalization.of(context).locale.languageCode == lan.codeL
                      ? Icon(Icons.check, color: Colors.green)
                      : Icon(null),
            );
          },
        ).toList(),
      ),
    );
  }
}

class ModelLanguage {
  final String name, codeL, codeC;

  ModelLanguage({this.name, this.codeL, this.codeC});
}

List<ModelLanguage> supportLanguage = [
  ModelLanguage(name: 'မြန်မာ (ဗမာ)', codeL: 'my', codeC: 'MM'),
  ModelLanguage(name: 'English', codeL: 'en', codeC: 'US'),
];
