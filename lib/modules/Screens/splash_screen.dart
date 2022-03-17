import 'package:flutter/material.dart';
import 'package:nida/data/setting/profile_pages.dart';
import 'package:provider/provider.dart';

import '../../data/providers/app_state_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
        name: AppPages.splashPath,
        key: ValueKey(AppPages.splashPath),
        child: const SplashScreen());
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AppStateManager>(context,listen: false).initializeApp();
    return Scaffold(
      // body: Center(
      //   child: Text("Splash"),
      // ),
    );
  }
}
