import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';
import 'package:measurement/model/general_model.dart';
import 'package:measurement/screen/history/notifier/history_notifier.dart';
import 'package:measurement/widget/c_listtile.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HistoryNotifier>(
      create: (_) => HistoryNotifier()..retrieveHistory(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('menu.history'.tr()),
        ),
        body: Consumer<HistoryNotifier>(
          builder: (context, notifier, child) {
            switch (notifier.dataState) {
              case DataState.operating:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case DataState.finished:
                final hisList = notifier.historyList;
                if (hisList.length > 0) {
                  return Stack(
                    children: <Widget>[
                      ListView.separated(
                        itemCount: hisList.length,
                        itemBuilder: (context, index) {
                          return C_ListTile(
                            text: hisList[index].history,
                            copyPressed: () {
                              FlutterClipboardManager.copyToClipBoard(
                                      hisList[index].history)
                                  .then((result) {
                                final snackBar = SnackBar(
                                  content: Text('Copied to Clipboard!'),
                                  duration: Duration(seconds: 1),
                                );
                                Scaffold.of(context).showSnackBar(snackBar);
                              });
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(thickness: 2);
                        },
                      ),
                      Positioned.fill(
                        bottom: 35,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            height: 45,
                            child: RaisedButton(
                              textColor: Colors.white,
                              color: Colors.red,
                              child: Text('history.clear_hist'.tr()),
                              onPressed: () async {
                                await notifier.clearHistory();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text(
                      'history.no_hist'.tr(),
                      style: TextStyle(color: Colors.green),
                    ),
                  );
                }
                break;
              case DataState.error:
                return Text('Error');
                break;
            }
            return null;
          },
        ),
      ),
    );
  }
}
