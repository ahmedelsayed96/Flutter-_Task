import 'package:flutter/services.dart';
import 'package:imei_plugin/imei_plugin.dart';

class AppIMEI {
 static Future<String> initPlatformState() async {
    String platformImei;

    try {
      platformImei =
          await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
      List<String> multiImei = await ImeiPlugin.getImeiMulti();
      print(multiImei);

    } on PlatformException {
      platformImei = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    return platformImei;
  }
}
