import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:measurement/screen/home/home.dart';
import 'package:measurement/util.dart';
import 'package:package_info/package_info.dart';

final appTitle = "app.title";
String appVersion = "version";

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(systemNavigationBarColor: Colors.green));

  ///wait
  WidgetsFlutterBinding.ensureInitialized();

  await Util.ratingCheck();

  ///version
  _getVersion();

  ///run app
  runApp(
    EasyLocalization(
      child: MyApp(),
      supportedLocales: [
        Locale('my', 'MM'),
        Locale('en', 'US'),
      ],
      path: 'assets/langs',
      startLocale: Locale('my', 'MM'),
    ),
  );
}

Future<void> _getVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  appVersion = packageInfo.version;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle.tr(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        EasyLocalization.of(context).delegate
      ],
      supportedLocales: EasyLocalization.of(context).supportedLocales,
      locale: EasyLocalization.of(context).locale,
      home: Home(),
      theme: ThemeData(
        primaryColor: Colors.green,
        primarySwatch: Colors.green,
      ),
//      debugShowCheckedModeBanner: false,
    );
  }
}
