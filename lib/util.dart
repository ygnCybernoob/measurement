import 'package:flutter/material.dart';
import 'package:measurement/service/sharedpref_service.dart';
import 'package:url_launcher/url_launcher.dart' as url;

class Util {
  static void navigate(BuildContext context, {Widget widget}) {
    Navigator.push(context, FadeRoute(builder: (context) => widget));
  }

  static Future<bool> goToAppLink() async {
    final appLink =
        'https://play.google.com/store/apps/details?id=com.cybernoob.measurement';
    if (await url.canLaunch(appLink)) {
      return await url.launch(appLink);
    }
    return false;
  }

 static void bugFound () async {
  final subject = 'Bugs found in အတိုင်းအတာ (Measurement) app!';
  final appLink =
      'mailto:<cybernoob.ygn@gmail.com>?subject=$subject';
  if (await url.canLaunch(appLink)) {
  await url.launch(appLink);
  }
}

  static String rlstDate = "rlstDate";
  static String rStatus = "rStatus";

  static Future<void> ratingCheck() async {
    ///check rate
    ///rlstDate : to check the last date
    ///rStatus :
    ///0 new
    ///1 remind later
    ///2 never
    ///3 rated
    final status = await SharedPrefService.getInt(key: rStatus);
    final date = await SharedPrefService.getString(key: rlstDate);

    if (status == null || date == null) {
      await SharedPrefService.setInt(key: rStatus, value: 0);
      await SharedPrefService.setString(
        key: rlstDate,
        value: DateTime.now().toString(),
      );
    }
  }
}

class SlideRoute<T> extends MaterialPageRoute<T> {
  SlideRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    Animation<Offset> offset =
        Tween(end: Offset.zero, begin: const Offset(0.5, 0.0))
            .animate(animation);
    return SlideTransition(position: offset, child: child);
  }
}

//from bmi_calculator
class FadeRoute<T> extends MaterialPageRoute<T> {
  FadeRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}
