import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/common/res/theme/theme.dart';

class AppRemoteConfig {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> initConfig() async {
    if (await _isHaveConnection()) {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(seconds: 10),
        ),
      );

      await _remoteConfig.fetchAndActivate();
    }
  }

  Future<bool> _isHaveConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }

  Color getColor(BuildContext context) {
    final colors = Theme.of(context).extension<ColorsTheme>();
    if (_remoteConfig.getString('color_importance') == 'purple') {
      return const Color(0xff793cd8);
    }
    return colors!.redColor!;
  }
}
