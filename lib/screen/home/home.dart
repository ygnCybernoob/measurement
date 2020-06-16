import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:measurement/main.dart';
import 'package:measurement/model/menu.dart';
import 'package:measurement/screen/about/about.dart';
import 'package:measurement/screen/converter/converter.dart';
import 'package:measurement/screen/history/history.dart';
import 'package:measurement/screen/language/language.dart';
import 'package:measurement/service/sharedpref_service.dart';
import 'package:measurement/util.dart';
import 'package:measurement/widget/c_menucard.dart';
import 'package:measurement/widget/c_ratingdialog.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> checkRating(BuildContext context) async {
    final status = await SharedPrefService.getInt(key: Util.rStatus);
    final date = await SharedPrefService.getString(key: Util.rlstDate);

    debugPrint(status.toString());

    final datetime = DateTime.parse(date);

    ///status :
    ///0 new
    ///1 remind later
    ///2 never
    ///3 rated
    switch (status) {
      case 0:
      case 1:
        if (DateTime.now().difference(datetime).inDays >= 1) {
          showRatingDialog(context);
          debugPrint("0 or 1 work");
        }
        break;
      case 2:
      case 3:
        debugPrint("2 or 3 work");

        ///nothing to do
        break;
    }
  }

  Future<void> showRatingDialog(BuildContext context) async {
    ///status :
    ///0 new
    ///1 remind later
    ///2 never
    ///3 rated
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => C_RatingDialog(
        rate: () async {
          if (await Util.goToAppLink()) {
            await SharedPrefService.setInt(key: Util.rStatus, value: 3);
            await SharedPrefService.setString(
                key: Util.rlstDate, value: DateTime.now().toString());
          }
        },
        never: () async {
          await SharedPrefService.setInt(key: Util.rStatus, value: 2);
          await SharedPrefService.setString(
              key: Util.rlstDate, value: DateTime.now().toString());
        },
        remindLater: () async {
          await SharedPrefService.setInt(key: Util.rStatus, value: 1);
          await SharedPrefService.setString(
              key: Util.rlstDate, value: DateTime.now().toString());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () => checkRating(context));
    return Scaffold(
      drawer: C_Drawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          appTitle.tr(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.report), onPressed: Util.bugFound),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 1),
          child: SingleChildScrollView(
            child: LayoutBuilder(builder: (context, constraint) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: getMenuCards(context, constraint.maxWidth),
              );
            }),
          ),
        ),
      ),
    );
  }

  void navigate(Menu menu) {
    Util.navigate(context, widget: Converter(menu: menu));
  }

  getMenuCards(BuildContext context, double width) {
    int maxColumn = (width / 167).floor();

    final listOfRows = <Row>[];

    for (int i = 0; i < menuList.length; i += maxColumn) {
      ///
      List<Widget> children = new List<Widget>();

      ///
      for (int col = 0; col < maxColumn; col++) {
        int index = i + col;
        children.add(
          MenuCard(
            key: Key(index.toString()),
            text: menuList[index].text.tr(),
            iconPath: menuList[index].iconPath,
            onPress: () {
//              print(menuList[(i+col)].text);
              navigate(menuList[index]);
            },
          ),
        );
      }

      listOfRows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      );
    }

    return listOfRows;
  }
}

class C_Drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 120,
      color: Colors.black54,
      child: Stack(
        children: <Widget>[
          Align(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MenuItem(
                    text: 'menu.history'.tr(),
                    onPress: () {
                      Navigator.pop(context);
                      Util.navigate(context, widget: History());
                    },
                  ),
                  MenuItem(
                    text: 'menu.about'.tr(),
                    onPress: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) => About(),
                      );
                    },
                  ),
                  MenuItem(
                    text: 'Language',
                    onPress: () {
                      Navigator.pop(context);
                      Util.navigate(context, widget: Language());
                    },
                  ),
                  MenuItem(
                    text: 'Rate this App',
                    onPress: () async {
                      Navigator.pop(context);
                      if (await Util.goToAppLink()) {
                        await SharedPrefService.setInt(
                            key: Util.rStatus, value: 3);
                        await SharedPrefService.setString(
                            key: Util.rlstDate,
                            value: DateTime.now().toString());
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            bottom: 30,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                appVersion,
                style: TextStyle(color: Colors.white60),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String text;
  final VoidCallback onPress;

  MenuItem({@required this.text, @required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: double.maxFinite,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPress,
          highlightColor: Colors.green.withOpacity(0.2),
          child: Center(
            child: Text(
              this.text,
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16.5,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
